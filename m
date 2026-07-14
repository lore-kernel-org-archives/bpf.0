Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904E83624B2;
	Tue, 14 Jul 2026 02:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783997725; cv=none; b=n8jpwXO6TEuzhHqbkokdYMRFldIcSXijpSScNNJOZgpon9wbt+2eiYGKzdijsSC2PBgbPM/MOQuPLWCjyVJVrtGiO9/b1tcqYH+CceH1vV87IjPCI6tLndfhoiYAR9AC5iYXZ0G8bvP+bmiD694D5QjCafV8k6zcamu+EY7Xx3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783997725; c=relaxed/simple;
	bh=EdRfws5VGdNGpD7YHKrBfHSCq7GTWLUE+uE5mCtUTR8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PBOtqK8qrusvmp+PITKXSRs/n9Re5ZI4r7k0e70wy41RLKdHmvlUqcDH4Mph14sf8DwAjYX1xQntjEqtGUpuoiLfQ/Z/SipX+h6MHylqc4AGdxLcoEzeY+InjjinWOKRcNaCUcAPvDkGE/KZMXd4pxPI4zMkASbsTLfheROWhuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gmonA6JH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gmonA6JH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04EA31F000E9;
	Tue, 14 Jul 2026 02:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783997724;
	bh=pD40xZvtuQrXN/MvvewOhM5DYqZCVCE5/okp9BgTKCw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gmonA6JHCARe/99qVF5EEevmR9Y5riFSnq7tObHU0uFyc0uIyXhIVc2VPlu94HkMV
	 3HFJ12yb8q0O3Ca1RXydptGNxTjXPK8UxbY38e1sr/Qchms5R0XIOAtHF2lOWNbvJy
	 dL62tSYU85GpRHKCJwGlTZv14s0nXAsykb6bxS5lOjG03KxUvrCsU40XdQr9v8SxQp
	 qEEXkRkXth/056yr2ac7zXHcxBpPhnzZ65RMtLcT0Wf3Ycx8pry6Dq7SmomnyePPof
	 OICOvdnYoC1H89Rb0YjNuIZRzFGnu7TPKQYggFI/8RP5hPhn4C/XNO1Y9pr4hjOfur
	 Lvf/czp/cBhLw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] sched_ext: Validate cid override before updating tables
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?emhpZGFvIHN1IChYaWFvbWkp?= <soolaugust@gmail.com>
Cc: sched-ext@lists.linux.dev, bpf@vger.kernel.org
In-Reply-To: <20260714024704.3318132-1-soolaugust@gmail.com>
References: <20260714024704.3318132-1-soolaugust@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 02:55:23 +0000
Message-Id: <20260714025524.04EA31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Splitting the `cpu_to_cid` array validation and update into two lo=
ops introduces a critical double-fetch TOCTOU vulnerability, allowing an ou=
t-of-bounds kernel memory write.
--

--- Patch [1]: [PATCH] sched_ext: Validate cid override before updating tab=
les ---
commit 3a1a6d6109297fa0a7f1d91d2dccc68df1527d12
Author: zhidao su (Xiaomi) <soolaugust@gmail.com>

sched_ext: Validate cid override before updating tables

This patch splits the validation and table updates in scx_bpf_cid_override()
into separate loops. This prevents partial table updates if the validation
fails midway through the user-supplied mapping.

> diff --git a/kernel/sched/ext/cid.c b/kernel/sched/ext/cid.c
> index af83084ec740a..e398e3f209bd4 100644
> --- a/kernel/sched/ext/cid.c
> +++ b/kernel/sched/ext/cid.c
> @@ -329,6 +329,11 @@ __bpf_kfunc void scx_bpf_cid_override(const s32 *cpu=
_to_cid, u32 cpu_to_cid__sz,
>  			scx_error(sch, "cid %d assigned to multiple cpus", c);
>  			return;
>  		}
> +	}
> +
> +	for_each_possible_cpu(cpu) {
> +		s32 c =3D cpu_to_cid[cpu];
> +
>  		scx_cpu_to_cid_tbl[cpu] =3D c;
>  		scx_cid_to_cpu_tbl[c] =3D cpu;
>  	}

[Severity: High]
Can the contents of cpu_to_cid change concurrently between these two loops =
in
scx_bpf_cid_override()?

If cpu_to_cid points to shared memory, such as a BPF map, could another thr=
ead
or BPF program modify cpu_to_cid[cpu] after it passes the validation in the
first loop?

If this happens, the second loop would fetch the unvalidated value and use =
it
as an index for scx_cid_to_cpu_tbl[c], potentially resulting in an
out-of-bounds write.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714024704.3318=
132-1-soolaugust@gmail.com?part=3D1
