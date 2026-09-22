Received: from mail-oo2-f39.google.com (mail-oo2-f39.google.com [74.125.231.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E0A3C5DB6
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 20:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790109200; cv=pass; b=hE0y67altGYZ94P5GQfpkwxGCoZ+hw+KCArMx4L8yeu/yBpN/NFxtS3ox/3v3TqKPfMUDb0KE/LCAw9/5rBh25Db5jsLdewez2zHCfCK5I8TabHGioZnB6hE9g4rEiKlcL8aRItqP0+N35+oimOJh2VloPlzMPwNCOUKbe0U4jk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790109200; c=relaxed/simple;
	bh=YVrKX0LV+9XXawTshmyoqahUAGMDRjhHBTCg4U2uBHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OcqFozfFmGxAfRyvJfPtLLBlHexmo9Ht/dPZUJVbsN6axSI3nHM0+tsM7ONvsqMbf5Le04+Y2jvV6b20ai125VOaETSh3qIBVdMTdYnqMTQTSxZ6nhOS8DE7Y5XAX7PfHTQ47ndjTmTSyKgP3HvzDE2s6BVckILvUQ/Q2kTEWzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WuXtR6Sg; arc=pass smtp.client-ip=74.125.231.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WuXtR6Sg"
Received: by mail-oo2-f39.google.com with SMTP id 006d021491bc7-6bcc0c495efso146766eaf.3
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 13:33:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790109191; cv=none;
        d=google.com; s=arc-20260327;
        b=gkISBIcQYOvDBxJBQENUl5l8CEB1gNdw02Vo8fbwSuP63c+iocwVmLUxCEgcMkVAzs
         ZIKl1v522TuWrmNvS5FCRBhlLnQHt7vOjE6tPbMbZvG8qUu20ZcawiHI1u5G62PUGCcX
         5b8q3ioQz4XemF7b0HzOQaAyJLoi6l1Fp91l9Rp5dyDDcgjTEwhTH35cLiPnaJ//6CBW
         kuqBiVdCGXI9xk+/anlAaazt8Y0nPm41+Q20aWd4qaC4RXkvA4cwKeuTaEIoZ6HSqA+l
         XSNxrWnHT+sq/MquETSfxLoZDM6anb3ssSDw2RyirVxWFXEiyYlSnU3RoQBX6oIvH6kU
         JGfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=H07YChWgthu6uT5lPpAm/6rWFjM+GWRx5WUSHRQ6MZY=;
        fh=Ihki2uHo2+n7gLJjZD0E7m9aHmSrh6klQEbS31s+Ewg=;
        b=UYBTuVvWRNgSyP6CKMKj5NuJPNVuUFKRgRhGFDSeezpifuEWojW6Xq4XnRrthAkxmq
         jP3rIkz45mjIVI6TKEiDB33mX3Xs/ciNRn2cj8RZPTE62skUTYJaKC2OXShlSyZrXqxu
         i4Ccmm1keCa31D8+pgUvrX3IBK1eWzl+sR7Fd5KdwImMxGoN1V4NbR/FwD5Z41kCfcj9
         NYskNXXWVsDh12by9SprXLXBFwAWeJ2MO8S2LsypKN+5+3ubJ497LGrxqwnY8ZHGel3e
         XiEIPKOm0fo9qf1ycYUXlpYqzcEjsoTpFCUxgDe6zDvnBmQn9kb5Pg8Z9n5QB5YylfIW
         yOZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790109191; x=1790713991; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=H07YChWgthu6uT5lPpAm/6rWFjM+GWRx5WUSHRQ6MZY=;
        b=WuXtR6Sgw6UVB2U1/iwbEBd/wKvxBh8DkVhl/RgCU8+wLUxa15cxwJ+sr8rfc6Yflp
         sjTvD/nz+rjjKC6uNB4IjRIBhGtjSN6uLx59wGz3kfsvZ1BK9XigObr3pSyI932zNOM9
         MBc6iM5kRtfI1cV8WsJ0aNGPFjEDl27KmjRd4+6bRdINBZswfRWhnajQQr/1WEJtUCMS
         ZNnbPE5MUekjSQ+DtuuSRyQuLnq8Hc1sfhPn9U2W6+WV3TGCpBeX9Jk9QYrd1wINXY6Y
         yoGlI7shm/6/CRPiJzYCTAP2DelDf5ShoS1MPeuJehzxel5WxMwjRYUXfHY99V1xIjRB
         HXrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790109191; x=1790713991;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H07YChWgthu6uT5lPpAm/6rWFjM+GWRx5WUSHRQ6MZY=;
        b=MoEqBRyXF63aQPpj5WEBnOWnqeIDmtZbscArxrnP0Tr3qbmr7unwrG9YQSC7hd0CnJ
         3NLtEvJzZUn41JfKNazMKGxaIFGNmSfE0OXwPF5ymQQkB4dba0+019tyVF3ev9BaLbJ8
         LIPVaRL+HyuG9KZXQntODiNv+MZ3eSXrefCt5hG+NfDCwd6jg2qheCBWE6vKNPc/TZ8T
         TizEHy+dF4H98lbzOYEiUb4FcCwG9n2/4mEqeX+ijAsBtt61JOA0xZ8POU1GHPGCFQ/d
         nNhqMJVqoxrqpzvEc1+n9d/b7xpaMV1HgELkmZUE4uLgL/FM//QH+TPR4VqkOt6wHyvq
         pinA==
X-Gm-Message-State: AFuF++lVo6s1uPJWL4R+8fpus7sNSm0uOw7k34fEYHNeqHFCxX+pdtIQ
	phukC+IsffvsvOfv9ttATz1QVXGlENCRoL65GIzRJEtyzu7/43sliUqHg+/Ai9++1Kmy18SaT09
	PvTkoyxHIV/ng0GZ6KJhV/aH4NdtbefA=
X-Gm-Gg: AYBFou1nAKkOKwf1SAl1uvoBIiTDM0cOzQwt8HLTIFJRn3sKCtIbkAzTFEAxK1OTCB6
	mLkGQdnaX9xJVrItwMgrGdkh0PZVrVZyGd46zU/6LJQHOn5fWfeQO6ppyjF0iJLTMZe/0G/SpkM
	27lgE8u9SiBdUL10bjIP6Ur0k9SKmPNpYBLL0rOzJYpc6UELR/W3x9r117jF0/8IbHR4oVZJucL
	105du/hck3xgmUCkt+QLX/9n/McgvDuPDTWHQ5WHOQf+alBjixin+yDPpOy6robMrrIshPTkZN6
	qdIfh+MyApzK2cir9klvGD6Q3fI+8d/MX9Ld7QvHyhJ6HSLP1XtUf91dAYFR3Epl8CfxU7Sh
X-Received: by 2002:a05:6820:290d:b0:6be:4eb3:e1c7 with SMTP id
 006d021491bc7-6d2cff43713mr471043eaf.14.1790109190880; Tue, 22 Sep 2026
 13:33:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922172028.6269-1-emil@etsalapatis.com> <20260922172028.6269-6-emil@etsalapatis.com>
In-Reply-To: <20260922172028.6269-6-emil@etsalapatis.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 22 Sep 2026 13:32:56 -0700
X-Gm-Features: AcwNN1VGJY6GqpU7_5pCNeCM2-B96aVCqu0qSFJBh6gFAmJnhMxteN-NYUreQhc
Message-ID: <CAMB2axOmSEshN1jT0MRDLTvnVu6YvbsUw5MhOrB3-mvUNbhmwg@mail.gmail.com>
Subject: Re: [PATCH bpf v2 05/11] bpf: Reject pkt arguments in mutating subprogs
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, daniel@iogearbox.net, netdev@vger.kernel.org, 
	Nicholas Carlini <nicholas@carlini.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 10:24=E2=80=AFAM Emil Tsalapatis <emil@etsalapatis.=
com> wrote:
>
> The verifier tracks changes in how PTR_TO_PACKET registers'
> bounds are modified across subprog boundaries. PTR_TO_PACKET
> registers are actually passed as PTR_TO_MEM, which is assumed
> valid for the entire call. This is not the case with packet memory,
> where a pskb_* call may invalidate its memory region.
>
> Reject BPF code that passes PTR_TO_PACKET pointers to subprogs that
> may mutate a packet. We cannot pass the pointer as a true PTR_TO_PACKET
> because we would also need to somehow pass the PTR_TO_PACKET_META
> or PTR_TO_PACKET_END to the subprog. Since we cannot avoid representing
> the pointer in the subprog as PTR_TO_MEM, only permit it if the
> subprog is guaranteed not to mutate the packet.
>
> Fixes: 80f281664f5a ("bpf: Support pointers in global func args")
> Reported-by: Nicholas Carlini <nicholas@carlini.com>
> Suggested-by: Nicholas Carlini <nicholas@carlini.com>
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---
>  kernel/bpf/verifier.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d62c0f74c..71ad07a9d 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -10421,6 +10421,16 @@ static int btf_check_func_arg_match(struct bpf_v=
erifier_env *env, int subprog,
>                         if (check_mem_reg(env, reg, argno, arg->mem_size,=
 BPF_READ | BPF_WRITE, NULL,
>                                           NULL))
>                                 return -EINVAL;
> +                       /*
> +                        * PTR_TO_PACKET get passed as PTR_TO_MEM, preven=
ting
> +                        * us from adjusting bounds tracking info.
> +                        */
> +                       if ((reg_is_pkt_pointer_any(reg) || reg_is_dynptr=
_slice_pkt(reg)) &&
> +                           sub->changes_pkt_data) {
> +                               bpf_log(log, "%s is a packet pointer, but=
 func#%d may change packet data\n",

This might seem vague to users. How about something like:

  bpf_log(log,
        "cannot pass packet pointer %s to %s(). The function may
invalidate packet memory\n",
        reg_arg_name(env, argno), bpf_subprog_name(env, subprog));

Reviewed-by: Amery Hung <ameryhung@gmail.com>

> +                                               reg_arg_name(env, argno),=
 subprog);
> +                               return -EINVAL;
> +                       }
>                         if (!(arg->arg_type & PTR_MAYBE_NULL) &&
>                             (type_may_be_null(reg->type) || bpf_register_=
is_null(reg))) {
>                                 bpf_log(log, "%s is expected to be non-NU=
LL\n",
> --
> 2.54.0
>
>
