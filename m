Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A185F33ADBA
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 16:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777047152; cv=none; b=nsph3kU/wbZjiH/VL9vBehaPkTw1cGtldx0WnKvAL/+3PmCHW3tGGQDGo7ihcPY9Zo6WZb+dZpn0qzdxnnVIrk7zTYyWxdjlFQ72XNwvLmptafz0GlnYDiJnitxjpD8aOZXQef8ST/Pc7wh//Fqo9KXmZunp/Z+tM2Y7LXX7xLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777047152; c=relaxed/simple;
	bh=zHCNzjAEvImYBkt78Z/qeVgiu4k8EbKvqCySOOROpJc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WOqKRaXiKws3q3biNhamiuA6zoxGUF68Ay9wzcF0NIrgscGB8+xCpuFm0qW1WngX1U77motdqaLYj8ZUHR56RPZoczjefGeaCehYLDjjNYTxkh46kzdsWey2WFLp2iqqUMXBt3BbnLipq0jY5GVBHp+9WrMpkOyGEmlLFKQOemM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=szqr/l/j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="szqr/l/j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B14DC19425;
	Fri, 24 Apr 2026 16:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777047152;
	bh=zHCNzjAEvImYBkt78Z/qeVgiu4k8EbKvqCySOOROpJc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=szqr/l/jLQ6YuBiLn8HfPfoBx9QtJ8Il06iW4Nmd+HfSatxXdmo2DWe4ZhBhBNYWX
	 07PB/REpOvfcuEmy8ZRBDnMR8XqxNQfOeIKQlESbjQah9ineLW5Co77OJOYi2OwUGb
	 /pMrNUDc8PUEp1p9Ow1YKpMeOACgYy4vb1YeMD6nNf2UDS10gK2S7ZdQJVeNEezwGA
	 wtiFzyRezPtoyOAmdqibByInnNdBxCIamHKTkVUgm3EEPRxqUMQkA3Ggk66ROrINkk
	 8iogGNrGmFqOloFehygUUmabu99eurZwRO3yceQS3Ppsrb96bkueuXtuTgE2TJFZDy
	 S+dB7mrWclckA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 1/2] bpf: Do not release trampoline image in case
 off unregister error
Reply-To: sashiko@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260424153905.354922-1-jolsa@kernel.org>
References: <20260424153905.354922-1-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Apr 2026 16:12:31 +0000
Message-Id: <20260424161232.1B14DC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [Critical] Use-After-Free of BPF programs due to leaked trampoline image
- [High] Permanent memory leak of trampoline executable image
- [High] Use-After-Free of ftrace_ops and bpf_trampoline
--

commit 3c4d55e24f28fa5f7f6dd937603366805532d1a4
Author: Jiri Olsa <jolsa@kernel.org>

bpf: Do not release trampoline image in case off unregister error

If unregister_fentry fails we still have trampoline image attached
to a function, so releasing it could trigger crash. Releasing the
trampoline image only when the unregister succeeds.

> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index f02254a21585fa..01082ecc5c4f5f 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -618,8 +618,10 @@ static int bpf_trampoline_update(struct bpf_trampoli=
ne *tr, bool lock_direct_mut
> =20
>  	if (total =3D=3D 0) {
>  		err =3D unregister_fentry(tr, orig_flags, tr->cur_image->image);
> -		bpf_tramp_image_put(tr->cur_image);
> -		tr->cur_image =3D NULL;
> +		if (!err) {
> +			bpf_tramp_image_put(tr->cur_image);
> +			tr->cur_image =3D NULL;
> +		}

If unregister_fentry() fails, the ftrace or fentry hook remains active beca=
use
the image isn't put. Does the teardown path, like bpf_tracing_link_release(=
),
still proceed to tear down the link and free the bpf_prog structures?

If the BPF programs are freed but the leaked JIT executable image is still
attached and active, could subsequent calls to the hooked kernel function
execute the trampoline image, dereference the hardcoded pointers, and execu=
te
freed BPF programs?

When unregister_fentry() fails and bpf_tramp_image_put() is skipped, does t=
he
error propagate up to the caller where bpf_trampoline_put() might eventually
free the parent struct bpf_trampoline?

If the parent trampoline is destroyed without freeing tr->cur_image, does t=
his
leak the struct bpf_tramp_image and its associated JIT memory page?

Additionally, if unregister_fentry() fails for an ftrace-managed trampoline,
tr->fops appears to remain registered in the ftrace subsystem.

If the link teardown ignores the error and unconditionally calls
bpf_trampoline_put(tr), will direct_ops_free() free tr->fops and tr?

Could this leave the ftrace subsystem with dangling pointers in its internal
tracking structures, potentially causing a use-after-free regression during
subsequent ftrace operations?

>  		goto out;
>  	}
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260424153905.3549=
22-1-jolsa@kernel.org?part=3D1
