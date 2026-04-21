Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8024E40DFC6
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 01:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776733536; cv=none; b=gGWohVJMzKHKKr7aX6zajhIF2JvJzvE411uY2tuuOdrzDI5OlJlQuO7yUx3f8/kUx7nNxT+g0UU2iSnMWw8lk5ebH9XtcmOJqvUa+89S/45FLqlng+p5xGiSAV8jfVgtHLiQiDmiosc0T+1fh6GwuAGg39mmmV1/7ilNrmpXE/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776733536; c=relaxed/simple;
	bh=M72hvlaIIZKjypO825pT90vixu7R0DXSaHcwh+3WXWk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rA3e8zAsDvWSaKkUlPzb7wfNnNssXav98oFJs6zXmZmOoZOpJgaCNNt38poEhbdnQX2qECY5kzPzQKY/NKU5Odd5wodQeBcm5lpKZfKltPMxqMe9Npt8gElnBNuuQCrtpn8JqQNCLVRfkWxVXaYbNjZ3hhp0rbHt7/6vSjNse00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pLRaWdGc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pLRaWdGc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17FB1C19425;
	Tue, 21 Apr 2026 01:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776733536;
	bh=M72hvlaIIZKjypO825pT90vixu7R0DXSaHcwh+3WXWk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=pLRaWdGcXE7MSR7pXj/GBJew1YS+JwHt+PnDEiYbqPOQMTnlplm4kJD6aKS9PwTLK
	 tunjKz2VYPa6MOn246h+bdYYTjoev76oThGQTKkZPv8/T1h5GiGUAxySjkhJl3dDQr
	 /PY6y+E2oZ1yz0as+8BQ4H9aoNqKCNIbZDkyJyV1e1q09QbmlRzoqBUL4V0VaeY+N9
	 Ir0HblKshCYcThCu1ovj3IXYixhZytLTzRwiv5vcNv4U3epwTAex37opkejBNmkPZ/
	 N7rzkW2vkFFKnydldRvqP9mg+SjoWU0V/uC/5Ykk8651BGYOcTxUdwUvUX/MdQAFC1
	 kfpvyCakzBEeQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 1/2] bpf: Implement dtor for struct file BTF ID
Reply-To: sashiko@lists.linux.dev
To: "Justin Suess" <utilityemal77@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260420203306.3107246-2-utilityemal77@gmail.com>
References: <20260420203306.3107246-2-utilityemal77@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Apr 2026 01:05:35 +0000
Message-Id: <20260421010536.17FB1C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [High] bpf_file_release_dtor() directly calls fput(), which is unsafe in =
NMI context and can lead to a system deadlock.
--

commit b9990bf55467191e86e004a62cdb84e6dc71b794
Author: Justin Suess <utilityemal77@gmail.com>

bpf: Implement dtor for struct file BTF ID

This commit implements a destructor for struct file, allowing it to be stor=
ed
in a BPF map as a referenced kptr. The destructor calls fput() to release
the reference.

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 2bb60200c2665..ee5ceb82e4f81 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
[ ... ]
> @@ -2752,6 +2753,13 @@ __bpf_kfunc void bpf_task_release_dtor(void *p)
>  }
>  CFI_NOSEAL(bpf_task_release_dtor);
> =20
> +__bpf_kfunc void bpf_file_release_dtor(void *file)
> +{
> +	fput((struct file *)file);
> +}

Is it safe to call fput() here?

BPF programs can update or delete map elements from NMI context (for exampl=
e,
in BPF_PROG_TYPE_PERF_EVENT programs), which will synchronously invoke this
destructor.

When fput() is called in an interrupt context, it adds the file to the
delayed_fput_list and calls schedule_delayed_work(). However,
schedule_delayed_work() is not NMI-safe, as it attempts to acquire spinlocks
such as the workqueue pool lock and timer_base->lock.

If the NMI interrupted a context that already held one of these locks, won't
this result in a hard deadlock?

Would it be better to defer releasing the struct file using an NMI-safe
mechanism, similar to how other BPF destructors handle this?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260420203306.3107=
246-1-utilityemal77@gmail.com?part=3D1
