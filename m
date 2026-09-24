Received: from mail-wr2-f10.google.com (mail-wr2-f10.google.com [74.125.225.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940D540F73F
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 07:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790234329; cv=none; b=pstoRzG5PmS08UZIlTGkhIl+qqrOgj0gHwDP0eLbEpE/8JPfelteKrlFVgxr8FNbndzfxUd/cz9mvdJnMJXOKrrnvNi2cb/XdnTv+4bswlk7tSC6AKHo9NE2JZucVk9rCoa/ybWaUq4AGn2bLfpckWOXHqEO3moXz6cc9t90dJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790234329; c=relaxed/simple;
	bh=RkQZIUAkC/CwNHAccWBmK7QrU2UwzqU4lzfZ5AArSQ0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=bXmXx1zzOWulX2/0pwD9KlDSWcrKkpyHrfzFXCiDPJ1+iyp+/gHPnQOVdmaCVgwdL193LJiDnIwUYfA/JHPshBrZ3jhZb9bXHy+kTAa8EKwWMqLR9ePz/sVeKv9p17rF1HLcmPcwFHawXN3cMIV7JkGk8COxyR8VqD9zCjqUj4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oGp6lhUf; arc=none smtp.client-ip=74.125.225.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oGp6lhUf"
Received: by mail-wr2-f10.google.com with SMTP id ffacd0b85a97d-484373a2e82so922990f8f.0
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 00:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790234322; x=1790839122; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=523fTptxsOAJ8wEQL/CwkuoPNTaX+slLlXT8PVpSULI=;
        b=oGp6lhUfWvnkLvJ/MVURmlhVmC6OALMjPL+LGNxfAwbC9qlCXbRrSUzDdyqAqn/J9L
         gmCMyGvkx4+uvATE2wOhLaY25Z0PDT/JjIvISRjXw0olQ+JxMiJcooXVf1KLKzP6n0Rf
         fcBHr+kl1HyjajyY5VRWVRIOxc0tjdXYxx0SUppJOdy2KsfWvgzoCQFBCsDKzCGtYaL/
         FzN9J7qrNLCOaG0ksSOW1G1hwYz673P+1mobMhbpPzlPPcqyQLvOjng/FNyDOT7SnH67
         8ow/2hhWHqYj1tQhm2tWUylVxK+ie9chXkffpqjsHy6YqBVUuGgW3I/e6xGqA+Kv+T6g
         SZqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790234322; x=1790839122;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=523fTptxsOAJ8wEQL/CwkuoPNTaX+slLlXT8PVpSULI=;
        b=hRx7/vfvFEUpFNN8fWoh2y4/RkorwALBK862EW6ngOESHG1tpDMMoq903VH+sH8jow
         u2DJpMyb/Fufi4awIsvL3LnenjIZY3yHb2aMNgjYsMVtZIk3+jzujzak8oP/o7Q6Ndcz
         0deKKnd9nPyaTyB6il7fF5PZnWuW3slD4gUDtzkrhMfK9RaA1X/bpqOOhSt8KiiuGkcu
         SOmXONmdZ6qNG/pzWTV1/seNHFeCQykDbwY4s8UACPYeVTP+jpEqACr8YfabLYjUAV1v
         a9yeJ7GW2KrHSpzDkHozfwQPB5CgxAuv+BTbOHdUHmDIOyUtTf4anuU90FiI43E6JAtR
         XkGg==
X-Forwarded-Encrypted: i=1; AKwUvBxZyXmXImHL/jqtzmhZnpjI4NRL66LVX/sZLyrl1rInk6q5McLa5mKJ0KEtKZzGJzWI278=@vger.kernel.org
X-Gm-Message-State: AFuF++l1Y5PPVz3kVoNHCBB70mi0EtkvFoSutSy8PI+4B3jo/rOjND9F
	fDIPmM3XNFtLL40va3It7BGaUTWnTOY4WcNX7NU54D8FaOtvPIylEjRX
X-Gm-Gg: AYBFou0pwQ8jzVxxxvyZX6eW1A67UwVGYb/duhnPe1yUoupYVayooN1ZIF9WhoXeA08
	7eZb6BStjKYZgXlhjUq52z6AjNeDnLyJIE/NrZSoPCgAVz46xqTCv1hLE0lrK5j0m0Cw++b7EMZ
	OwyepKPgs9TDBKODxhpPvoaUjjIKS8QJkahlouCxGCT4OU+MFK7AtyqXWu8iBdld+7Wk0StqutM
	qXldue7NKRMs+5uzq9j2+NfRUFu3D5WXShpY2qONRNBW3EG8ZlLUaPOVA56V4X3Ed8Y6Qbh6ddW
	CEKRith8mqxIS9B9N8PdXAu+Y84GnkNyBbLgmuZbhdaaasAJA7GDh+0zM099DH2Wd85Tl4J041+
	g5/6zgBqXVnbNJ6ykAnIFe2JRc6bGzmBW0XjAYL1Ugn/QVVzvfJLwJTaOYGT+7R64x6l+YAZKzx
	oiQm7wUSE+ni0aBFE6yKrSd3WP1BrE4Vm6nm0i43ZuhvcHXSdw1jRMKtZVK6lnHoPV+DVDuj8WE
	kfOXwauUvX6r1q2jdkbquIwKyPpUMCfux71yGRFJ1PpOhUlkenzIS4sYkOn85/E/P3ShwIv5q/b
	4RzhPuUER9jdMJ5pcmFx+UaXJaWU0Gj8L9jdMNaD3MdFltiI
X-Received: by 2002:a05:6000:4012:b0:487:8ec:bbd2 with SMTP id ffacd0b85a97d-488716c9360mr2499338f8f.19.1790234321688;
        Thu, 24 Sep 2026 00:18:41 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-488682668dcsm13312703f8f.1.2026.09.24.00.18.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 00:18:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 09:18:40 +0200
Message-Id: <DLND3P616VVS.RP36A73FJ1BB@gmail.com>
Subject: Re: [PATCH bpf-next v1 0/6] bpf: Scope callback arguments to their
 frame
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Alexei Starovoitov"
 <alexei.starovoitov@gmail.com>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "Eduard Zingerman"
 <eddyz87@gmail.com>
Cc: "Amery Hung" <ameryhung@gmail.com>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, "Nicholas Carlini" <npc@anthropic.com>,
 <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <kernel-team@meta.com>
X-Mailer: aerc 0.21.0
References: <20260922010333.1226537-1-ihor.solodrai@linux.dev>
 <DLLGYV7DI406.JRNDNAZ4S29I@gmail.com>
 <ddb3c0eb-2a95-4af8-a9b9-a0624d38a7bc@linux.dev>
In-Reply-To: <ddb3c0eb-2a95-4af8-a9b9-a0624d38a7bc@linux.dev>

On Tue Sep 22, 2026 at 8:13 AM CEST, Ihor Solodrai wrote:
> On 2026-09-21 6:55 p.m., Alexei Starovoitov wrote:
>> On Mon, Sep 21, 2026 at 06:03 PM Ihor Solodrai <ihor.solodrai@linux.dev>=
 wrote:
>>
>>> Neither has a local fix: both arguments point into a helper's own
>>> frame, with nothing longer-lived to anchor them to.
>>
>> It's the same problem as a pointer to callee's stack.
>> check_stack_write_fixed_off() deals with it like this:
>>    if (state !=3D cur && reg->type =3D=3D PTR_TO_STACK) {
>>            verbose(env, "cannot spill pointers to stack into stack frame=
 of the caller\n");
>>            return -EINVAL;
>>    }
>> CONST_PTR_TO_DYNPTR wasn't spillable before 7.3, so nothing depends
>> on parking it in the caller's frame. Reject it there too ?
>> and then no need for REF_TYPE_FRAME complexity?
>
> If we focus on the nasty bpf_user_ringbuf_drain() bug specifically,
> then yes, check_stack_write_fixed_off() change patches it:
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d62c0f74cff5..f261423e9282 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3668,7 +3668,8 @@ static int check_stack_write_fixed_off(struct
> bpf_verifier_env *env,
>                          verbose(env, "invalid size of register spill\n")=
;
>                          return -EACCES;
>                  }
> -               if (state !=3D cur && reg->type =3D=3D PTR_TO_STACK) {
> +               if (state !=3D cur && (reg->type =3D=3D PTR_TO_STACK ||
> +                                    reg->type =3D=3D CONST_PTR_TO_DYNPTR=
)) {
>                          verbose(env, "cannot spill pointers to stack
> into stack frame of the caller\n");
>                          return -EINVAL;
>                  }
>
> However it doesn't cover some of the new test cases:
>    - user_ringbuf_callback_park_data_slice
>    - user_ringbuf_callback_park_kfunc_slice
>    - user_ringbuf_callback_park_clone
>    - user_ringbuf_callback_park_clone_then_slice
>
> (not counting the diag message diff)
>
> The original suggestion that came with the bug report was a
> cb_dynptr_id field in bpf_func_state set up in
> set_user_ringbuf_callback_state() and read in prepare_func_exit() to
> release it there.
>
> The cb_dynptr_id seemed way too specific, I didn't like it. So I've
> tried to figure out a feasible generalization of the problem, and came
> to "verifier can't track a lifetime of a ref tied to a frame", and
> then to this series.
>
> I think we need to decide whether the REF_TYPE_FRAME is a useful
> mechanism in principle, and whether it's sufficiently generic. It at
> least covers the cases in this series and more.
>
> For example AI also flagged for me parking the vma argument
> (PTR_TO_BTF_ID) of the bpf_find_vma() callback. It's low severity,
> which is why I excluded that from the series, but "reject a reg type"
> wouldn't work there AFAIU (we would break many legitimate programs).
>
> Opinions?

Ok, I think I didn't realize the issue was broader than just CONST_PTR_TO_D=
YNPTR
type. In that case I think what you suggest does make sense, and might help
generalize the behavior across different cases.
