Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792569788;
	b=qI9e6y9+0Dc2yefVXH1BwNwNv8hbYX2rY+lnmXsU9oMV2KGTFrhsNlnGQykJdUHrBdgP
	 uPxJK7bJOeZw97nWWXyNw2yNu1GXGQTtxeA20pTgyMJYaWIBELpSPmv2X1GZNcLdyT3pj
	 nyrfkEFn0NT6RzEg0/XOLOe1lNAhQrERGn19ZWPIlHP3i0h7KIUwC/xfyrDbqHp1nlr5x
	 JnkV59kHRM23wwaDxqop+DkHRHw84u7NMhjTnWQ3RhWxbmbFORq9vuUpqf4Tegt3sAz1e
	 NAGCC11Cdvc/CFyI4d2QJqmSC7/SFc1Rd7LkSm5Rdtt/rwRcFOlW3Z2dl3SxAfmj2Ow==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792569788;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Ej31f8Bh0GlgZxOrxR/CUnpvXclq/RwzuQxNVYI/rTk=;
	b=PMU2F09ExkewppobMMsJKs0ffpEg6ZSMljfoET5+dlB2yhkiamdunDO86AyOZStuPr0u
	 jpUwlST018GLaiDDHkeXsMyrRMMg1hr7duUvNFskhGt5ay9HW3mZz/MEodqHuv5pg9HUd
	 wwIoLa3LSklQT/yS+LXQU/dIaon1PNwWjqtkzpXH+vUTwvGVGjncszGPCk61dsnwNt5kT
	 bE748+fEyU2vau/rY2yGAca2rJ47MPagMTqFi2yR/s0d5+Z6UO71Cl8QeJdfCLKLKPdm5
	 6mtm9mOONNlBFG9nltcGcyWk5rcXEs6kerm7xei54x5wzilvROWF1rMRqbojrSZVUAw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=g3Cd+Fyn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.41
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8DE606A31B
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 08:03:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD8DE606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=g3Cd+Fyn
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c45551fa84eso49976366b.3
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 01:03:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792569786; cv=none;
        d=google.com; s=arc-20260327;
        b=T+Yh0WlFzXR1HVIS3ApWn0ov1XspJPQLgIaMWRNjpBaOmo+/czv/NUCfOlHoYbUIK+
         Fw9JTzhzMtNaZGk7PwJ8cufHMXtdoC46ujeOqJuqsXEAks9frCYM63/VBn9gqtxkNx43
         Ee8O/ZyAqPuSChwBKdhcmtYGuKw91DrJgxxzSDHTSKVoqKzh6FJc7WtitCmlRfgASYSb
         thO2d6qTFopJ5Nhmnbue/VN9F5RGxd05YygSjqXxnok7iwobxvF7O3KuZEN2FqH4DooF
         SVXfHpuowyMfQe1bgKaqhI1fBsWz8RTWisAYbEf3NszDepCURyqalqpBdv9XdbDroZfM
         Wk6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ej31f8Bh0GlgZxOrxR/CUnpvXclq/RwzuQxNVYI/rTk=;
        fh=pex76OzqRUAGF7OvnYNb3XqFp9mmMDbtWC3/VuxUDC4=;
        b=eCc2h6aflD2/gqUH+BuZS9eSzaNwfSt8FoBilPfCSopcwlwlj64aXJlKsBYxTVJou5
         A5iVcQXBv6hEpBeTqIBZTVBPElXaoB309aHrJOQQkucxlD4lsSgJ9b9EfAE+Hp/xY1Al
         7LgrxK/y2nn/6duN4jmbNKfHwQgdVU04qwItU+tr9Em5sLWgUTyykbVAKRMuyk3KyT4K
         O1Ur00X2G0sczKIrtWnQul3F91iQI4DeIlgjXDYhjrL63kZvDQdLdBBK1xPW4jFq4d9V
         wk08G54W9NEtXVu5u0fRbky1RdCm+ac/uI3nyVoQZ0mZ4e6Q3TnRQ3fqz/8c3IxruMuk
         eK2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792569786; x=1793174586; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ej31f8Bh0GlgZxOrxR/CUnpvXclq/RwzuQxNVYI/rTk=;
        b=g3Cd+FynkjVeyyUXzJLNcAv+eWioETg5se1yMO06rcTkAfrTeW3uMCwTxhp4L71vks
         2fGjQFulLIQyYUC1USdVwgm+aUBSF3EyO6nAdRZ9e/ZZMCjHpuux9JdbvWdsJcRye08Q
         tvD6EDZE0Z8NSWkGsYF99+VT6s18mBAQFsbXdB81eKTjwQXmEdam7c1NpiUds9qVX/V+
         k6/fpi8UquptukobWIjCFeHUClcloAcGUY/k9yRT1rBbTgDgjWVtAODD0fR3UxUr1nXM
         1hxDg7mbZp/V2Ocg1VA7A+AH49WYmDcxTKh6/DKw8we+NlparSmzs2YXhgcjs8FempQt
         R1lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792569786; x=1793174586;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ej31f8Bh0GlgZxOrxR/CUnpvXclq/RwzuQxNVYI/rTk=;
        b=q/M7OrGF3QZXR8H4rzN4cy04fPO/rQmR8CkAASYNdLDVUwKAMEyajPfjveB7Ojv7/q
         HR8Z1qP3xlAODtAvDN2OpEH5tTNqyfUxZutOh3+E15rY3ZjiajZkXhJDSK79sPASVI4V
         TtqO1UYNkMqxncTF7hYVm5oMBHqfWRIw4xTN9RxMmxaJXdyksppyNz5UxvktosrJvew9
         2+LqDLh9veqxvGEmTCCw0yJHTqdV/sS9hGcAjvqU5FN2tvcoaP67PL+1nXEqHDBnw63O
         zBubvMCnjbkZxwnVPurBROKTu9QzsiGvaDQ2ZbvAKrlI8Qs/4VhBmp3jv2Qsp0KaH8Hm
         wVnw==
X-Forwarded-Encrypted: i=1; AKwUvBxA0rG8hpc9h6ilhbSOq/l2Jq0kWQOSbr42LRjbLZdNihMfuI8r8mVSiiv1KJJDG3TWsQs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKFgyJyJBTLbdNvm81RAg5BzbxF+2nE4MT9uyaf77KCRIHu6G8n
	muteOX4NzhvcEcMbhEIhcAag0Si2HZ4bbtHx5qjt157CZF9Ka5qc7FNS+IoPnYEE6eAKVpYGqe3
	rI7Qe/kGsEQjnu9kawOLZZPkNGx6cJMA=
X-Gm-Gg: AYBFou28SYON/onrdaphmReammXlNNiRVdKUuIoyykHRe+ykh6Z3CG/Z+mkvzrcuJXI
	pe8XNgyFiJmKSkCjLjEgzliVksxISMR/Ed2F5U8BdH+0bDPXR5CCRGUsB1DpPqfHyylo5v/bHZa
	4UqQ2Nrywy8VgsoL4jwyKJENgAfd2ZlLAfx9a53XkRg/2Dy8sxePEkX4+Ma4uQL+XROMZ6Y3Qli
	NEvoJdy2NcYfwgvoLV62Wrc1gqP2E1JJXZFh3xdRI2JpUhkOU1q29Mtq1eoXSWk7s1AYM9nichS
	4x+AISReR7XrAFCnd6zzozqI6YxzE4uvOTdbI9a+csrYAI/dFlPmLf+VCdChq10rZdiQRDEju+g
	dPTSIkiMOdNbjjhcmEYt76zSvHZg2QS5ToXDti0stf7TM8qbncVWKqhuImE77b0q+14+J
X-Received: by 2002:a17:907:2dab:b0:c31:8441:35ff with SMTP id
 a640c23a62f3a-c467977fc1amr128101666b.48.1792569785669; Wed, 21 Oct 2026
 01:03:05 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261007174203.37071-1-bestswngs@gmail.com> <DMA2R8KIUPO2.SR26IDI6VG35@gmail.com>
In-Reply-To: <DMA2R8KIUPO2.SR26IDI6VG35@gmail.com>
From: Weiming Shi <bestswngs@gmail.com>
Date: Wed, 21 Oct 2026 16:02:27 +0800
X-Gm-Features: AclHuK-B2UJm3TNMWcVkqmeDjUYIvMQv03wgwI23bq25rlqm3v0pnRffiE9A14E
Message-ID: <CANgPUi3Ow2Y_W_-v93yOz2TF-Qa=omZf_VuwbMuv=itc1tUYhA@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: Validate stack arg reads against caller state
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Xiang Mei <xmei5@asu.edu>, 
	co+eada64ce90ecebce@bugs.sh
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Alexei Starovoitov <alexei.starovoitov@gmail.com> =E4=BA=8E2026=E5=B9=B410=
=E6=9C=8821=E6=97=A5=E5=91=A8=E4=B8=89 08:03=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Oct 07, 2026 at 10:42 AM Weiming Shi <bestswngs@gmail.com> wrote:
> > then read a slot that the caller never allocated or initialized. Async
> > callback verification also starts at curframe zero, so subtracting one
> > to find a caller can underflow the frame array.
>
> Sync callbacks are broken too and this patch doesn't help:
>   *(u64 *)(r11 - 8) =3D r6;
>   r1 =3D 1;
>   r2 =3D cb ll;
>   ...
>   call bpf_loop;
> where cb() has 6 args in BTF and does r1 =3D *(u64 *)(r11 + 8).
> The slot is written, so check_outgoing_stack_args() called from
> push_callback_call() passes. push_stack() copies stack_arg_regs[]
> of the caller and the load in cb() gets the state of r6.
> set_loop_callback_state() marks R3-R5 as not init, but stack args
> stay readable.
> At run-time bpf_loop(), when not inlined, calls cb(i, ctx, 0, 0, 0).
> x86 JIT reads arg6 from r9 and arg7 from the stack frame of bpf_loop().
> The verifier thinks it's a map value, but it's garbage.
>
> No helper or kfunc passes more than 5 args to a callback.
> Reject callbacks with bpf_in_stack_arg_cnt() in push_callback_call().
>
> > +     if (!vstate->curframe) {
> > +             verbose(env, "invalid read from stack arg off %d without =
caller\n", off);
> > +             return -EACCES;
> > +     }
> > +
>
> Only async callback can get here with curframe =3D=3D 0.
> With the above it's rejected earlier. Drop this check.
>
> Add sync and async callback tests to patch 2.
>
> Also mention in the log that
> commit 4286f5deee14 ("bpf: Validate outgoing stack args when btf_prepare_=
func_args fails")
> closed this hole for the first call only.
>
> pw-bot: cr

Thanks for your review.  v2 sent.
