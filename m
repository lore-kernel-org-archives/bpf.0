Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6BB4D795D
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 22:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790633021; cv=none; b=DxK6zEVC0ZYglUn2oh2MB5sXfqIyoWdjIja8FAKV2l0Cf4t8J1xAOw6Fgj3UAmNs/MqpLO/whrPRlJSP4QKOxgxjMl11f9qMCRt0IZquDWdra42W/vswrYSIdXFKWCEiKHQBuhLygBhi3uKyAwmcwn3aaU9WBvun3tbL8lzCxKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790633021; c=relaxed/simple;
	bh=qe66IsUGLcU1aN/OVsKwNb/a57Cj2xeC5+mKssiSve0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P2itrcZItCFb+qSiouPZJQwt1hEw+EtrzQFJidRCzPaQ0QgR+7MHADHn/KLdxbYSksy8EMzNmLl5tu2aTxrqe8SHpT9WF3GUQ4pNuLwReEOBgSttH84ICUVP0Ilo6InsGDiQRkxAkeQgMfZHKd4dn7BNzjs5yB/YbP1L4NO8kvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1kEALxm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1kEALxm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 168F31F000FF;
	Mon, 28 Sep 2026 22:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790633020;
	bh=sGfYcjpCSvPagmu/uKf8aGJ6cqF9qLQ+3xY8nwgnJeM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S1kEALxmsnxWpIKHdj1rAFu28MFBDgNvSsQeOQCkvtbqONGM44qNX/2ouDNdvj6AN
	 nyNClbzYbbCKgBSGLpfVq6+8cLeMA0t5jSE3d25DSYwc6ew3SZPL17Wbkf86ClqpzV
	 kGKEuDUGOrO/KobWtLPyKmTQmlDf3BEGu3jwGADHknh731cmRICOvK0RWDgfTokAqQ
	 CRwXZ+o1ae4a54mu0ldUVwP1XzFlrJ9PS4mxqmneUhlBhzDZSmpLvURUAm5bWYsdEe
	 QDvtUGXVrRR3XirkdD49mccLkTQa+Hnnm4Ryn8FZLd5+pmzv68Gk7TLmULKW39TaON
	 bRgTTJOg+pbag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf] bpf: Zero-fill non-target CPU slots on BPF_F_CPU
 insert of new per-CPU element
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?w5ZtZXIgTWV0ZSBLYXlh?= <omermetekaya0@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260928214932.544124-1-omermetekaya0@gmail.com>
References: <20260928214932.544124-1-omermetekaya0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 22:03:39 +0000
Message-Id: <20260928220340.168F31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] bpf: unreachable dead code added in pcpu_init_value()
--

commit aa9c1147874e7681c03a2eaf750ae6f2bf2a633a
Author: =C3=96mer Mete Kaya <omermetekaya0@gmail.com>

bpf: Zero-fill non-target CPU slots on BPF_F_CPU insert of new per-CPU elem=
ent

pcpu_copy_value() with BPF_F_CPU copies the value only to the target
CPU's slot and returns immediately, leaving all other CPUs untouched.
When inserting a *new* element, the backing per-CPU area may be reused
from bpf_mem_cache or a prealloc freelist without being zero-initialized,
so non-target CPUs retain stale contents of a previously-deleted
element in the same map =E2=80=94 a same-map information disclosure.

> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 548eb1cc7c45c..f426d4c00bdc8 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -1086,6 +1086,16 @@ static void pcpu_init_value(struct bpf_htab *htab,=
 void __percpu *pptr,
>  		}
>  	} else {
>  		pcpu_copy_value(htab, pptr, value, onallcpus, map_flags);
> +		if (map_flags & BPF_F_CPU) {

[Severity: Low]
Is this block reachable?

Since the preceding if statement in pcpu_init_value() evaluates
"if (!onallcpus || (map_flags & BPF_F_CPU))", the else branch will only
execute if "(map_flags & BPF_F_CPU)" evaluates to false.

This makes the newly added code here unreachable. Furthermore, the new
element initialization issue mentioned in the commit message appears to
already be handled correctly in the first branch, which already zeroes out
non-target CPUs via zero_map_value().

> +			int target =3D map_flags >> 32;
> +			int cpu;
> +
> +			for_each_possible_cpu(cpu) {
> +				if (cpu !=3D target)
> +					zero_map_value(&htab->map,
> +						       per_cpu_ptr(pptr, cpu));
> +			}
> +		}
>  	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928214932.5441=
24-1-omermetekaya0@gmail.com?part=3D1
