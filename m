Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7391138DC79
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 17:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788976045; cv=pass; b=jEfc6U22iDJVtv8WLJ+xvoRzoe7eKOCluLz6yi5bz8fS5TmhFt8rR8pJ/Q6Ul5GYQFjIr0XYKCXYYnObhGlzqXhOeCuSedBlLeUErlfbjMkZ6OLncw6lIMLgOJ+m8DDqXHFNV9mQhEMJTuO+Oz3BNnSbNKAHhnsFij185y9dTFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788976045; c=relaxed/simple;
	bh=KsqAWLLSXZo92IG1R5rVfZj7CJNUliWyytvzo16n1l8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W92GD9l3GyQmr9qVbMG6kCHcEyUgVP4P19TkP5QWt3lu79+iJW/+6Swu3noF8YeuploEN2WQ4dh6UF8dHwziIiMJjQWn29Uv3FbE4zH/ysJVHWpHfXusG3AGz86odLLosSDSTjzSb+ag1Ht4FdEt2tdhqHqCKCfR5RiV3ZEv8Cs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FbNyVei6; arc=pass smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FbNyVei6"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7f4f53975e6so5868170a34.3
        for <bpf@vger.kernel.org>; Wed, 09 Sep 2026 10:47:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788976043; cv=none;
        d=google.com; s=arc-20260327;
        b=dYrxIefmThM/It65Qphh2qArOI5XSiXX/iIBTpGkoXIbpz5xse+iQJhDGgj/7ewMdl
         gl7fl4dPfJeEh4X3usr5OWr3jHGjntL843bJDBdXwXSDBCTi7esn0uwa3h5/6KVJyc85
         0Pr1bARDYuuZCXIn6hzpxNZQXdlA5ioPMqq6p++0XzyEGxfsGjatqEid7LakaY1TMrVn
         V/sAvG6iR10sBcRU21wpD6bgzO3pnp1oWt3D1Ycoij7FdG9uF68y0fUQBbANsbTNW8uC
         /YNw8vXJgAv23EvC2++dvidvya5gVrOjZvw7kddKDqmGKnHu2fmsMFlqkGlkdYrAUhCg
         ZObQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qNoOl7ztrPCmUz3TRKSDyhyxAS0+0cTZFgolPiVjjcM=;
        fh=+iofH7kLhUIpDUAo/a2rUbKulXCH8Go9n65YHAt0kP0=;
        b=ExeUFfXnle6oUKwOA9DEx5nkE+YoWdOZdZB5c5BkyrO7iMU+FdG2HdhWSqS17FnXWW
         1AN8P2m77K4jvwKC1FlFD3WocOq9B4rLkEEp7X1TNfK+O8Y4nbaqLMgwlgEdoXsKY7CP
         E2cX82F4qHMIRhzl3+gSBMZ3Q9RiPGdk07d77Gqti8rxaBFgpvNVJjB7fZC5XfuE1U9y
         KldiAPq6ya8OLRU5r9m05JCY4gZbB3QxhYTFORB+LIbvbJXc+gioXVYVhkyzguuQRA+J
         J1CDys2rG9Rdy/nXyBYA+1QwqIF95zxTTXh3c1WInchzcwUkrq0q20qxRO7rrH76pgPh
         /UhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788976043; x=1789580843; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qNoOl7ztrPCmUz3TRKSDyhyxAS0+0cTZFgolPiVjjcM=;
        b=FbNyVei6X9FXnM2IKA9vaialx5roahy0C/T4DDA2JtauhrsUhWV4n23odpsedbUL5z
         1xFKOXWmcER5Mc/wPZvSQbX/GIjicrdE/eLUNwd9lLGrgKCFng06dwE8V1ZjEH3GEbS3
         0H+p6A15jzj3qHJUHs1rJTHwc0etDs8RlGIoTypV8isaSeAp/l0GgbuoKItQHKfek20t
         7PdWWYMilV6hemp2CJBrigz6TJ2LPjrnIKNdl43RGiZ7/OZ7+nb07qN28mwrttiiSx0v
         denF4Q4Ajun358Cc4YXk136wshTxNV4Ac45a/p5Aw8X4qFWWuuIvz0z2p/8QlrgvSvrj
         Ec6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788976043; x=1789580843;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qNoOl7ztrPCmUz3TRKSDyhyxAS0+0cTZFgolPiVjjcM=;
        b=AWsuzxWq2N1bdR+i4hUNRX1dxaof82Kaw5VrBWtMrsrp2EbN7gu7Ct5YzKQFsEFtdB
         +nwYeAjwBJPiKsN9L/aayMV9ZGncvbonfOg5+EPdMn1haw79ynNOo15uI9BEZPvI/EyT
         jPIvVorw2T4h/wmNre4P7UCFtPEKOfEtpgXv9c27ZNxmhmhlUbJ0AQV+l+KNxJ2MEX8g
         Ob/7WOpCR+MO4xkWR4+siKODe884nJtI53kBDnD4zneyk6vW2Csb9dbI1CmJ7T0L3HS1
         SVJejuWSSzrcZEdL7DbyfQEI3T/xfB4mXYfWHEkJiRtKyUOBh46ywUNYFPYh5Uyns4vc
         O15w==
X-Gm-Message-State: AFuF++kcN6TSCGCSlwNtlz68uKtbZAMz5NUYv+EGCdwtoXW62bBPLinN
	+inEqvhu/unpCOc9FZ1DwEaoN+nC9D7MGXt1DkB34iyEpjxRER/Vis/FBW6eNerxRGaBrUt107L
	YG/JDLfG4ycN6Qp9yg3aehtttaa9UXzQ=
X-Gm-Gg: AYBFou36ZllswdvE4RJIkJi1LCvrgtlv9gjhNg6MWaS5We6Zh1FVbqStv6AwHvn3q4l
	xuFz1VHkfYutXCXegK6pxC5jHnkHWpOzTNkk/ZZb8pIqvOZ44j6dLnvFFPLBfGMd2+CEcke8q1Y
	sPj+JyreWqYxzw1Je42G9hzbpmifUHIpZ7KOM7t0aXvsFt8WYmz3UQj3s3LZOqhXeFNrZ2W/Uxr
	kVlBmWj/PbgjerisnGmn4q/1HPafmxwVw29gHArTXwilUMtKWouJJKXsGwrBs2Gjcx6r6l5gPbL
	62cjtzHAOlwxmknVF05Bkdxhp5dTde7Cpxq2gn1UZEwl0g32XRK5It0hVmwDfMFmO4fZmw==
X-Received: by 2002:a05:6820:c86:b0:6be:d716:524d with SMTP id
 006d021491bc7-6bed7259579mr1996629eaf.64.1788976043133; Wed, 09 Sep 2026
 10:47:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260905220117.922028-5-ameryhung@gmail.com> <5be48987cfe75e107873b539eb72a03021979e0e2a14e8bdd0c4fb8f592b3a8c@mail.kernel.org>
In-Reply-To: <5be48987cfe75e107873b539eb72a03021979e0e2a14e8bdd0c4fb8f592b3a8c@mail.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 9 Sep 2026 10:47:12 -0700
X-Gm-Features: AcwNN1WJbKaoZm-wkeuX6pUYNOc6F2sKzUQFOHIqWtyIIQvNIvxvsQnT5OvdPSc
Message-ID: <CAMB2axPt5ObMVprJQT42T29zTTXhhcUDjgWfxfWimhK0YUfE6Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 04/22] bpf: Only compare func_id against kfunc
 BTF IDs for kfunc calls
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, 
	kernel-team@meta.com, ast@kernel.org, martin.lau@kernel.org, 
	yonghong.song@linux.dev, mason@kernel.org, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 5, 2026 at 3:44=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > bpf: Only compare func_id against kfunc BTF IDs for kfunc calls
> >
> > Helpers are identified by enum bpf_func_id, while kfuncs are identified
> > by a BTF ID. Both values are stored in bpf_call_arg_meta::func_id, and
> > a helper ID can have the same numeric value as a kfunc BTF ID.
> >
> > Introduce is_kfunc_call(), which first confirms that the metadata is fo=
r
> > a kfunc through meta->btf, and use it for comparisons against the speci=
al
> > kfunc BTF ID list. This complements is_helper_call() before later patch=
es
> > move these checks into paths shared by helpers and kfuncs.
> >
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
>
> This looks like a bug fix for the helper/kfunc metadata unification.
> Should this include:
>
>   Fixes: bf9c1b911f4d ("bpf: Unify helper and kfunc call argument meta")
>

This is not a bug fix. All converted comparisons are currently reached
only from kfunc verification, where meta->btf is non-NULL. It is only
needed later when we move these checks into shared paths.

>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/339954=
42755
