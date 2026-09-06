Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1F525B0BB
	for <bpf@vger.kernel.org>; Sun,  6 Sep 2026 06:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788676859; cv=none; b=kEY+hdAlP/BhYTANcvme6QJLx78HM2lvqHki4i2KCKZdNs3RnwktTIn+oyB22YT1HZKDnIJEaa3KDKn7IjBFIAKebDj6B5Wa7hf3QUQD9Wy3qDFe3fDHC8bCT7Ns8q7b1Iygeo4YpYG2fioUBtPPtNikaNPQVDJ3cPkrctxQZTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788676859; c=relaxed/simple;
	bh=Qa3S3W7xBkav+OWPBzk1DCjZ2iqdH8IXTPUiL03S2ns=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qNf860vSQv/QmP0eTGp8fSjW8TVgb5E4S+fdjy+mpXkXybkp0mzEbOz6bRG/koQpf/GvIJeva8hdbN8Zn/0Wwc0pevbsIXtSqeZ7xy/LD+jJcHE7zohCJlMcIlnTSMlP38mCqqA7JtOVp2T3ADU1vabFa7M77e3K87UJbkpalGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EQNIrAuB; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQNIrAuB"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc1d57602e8so2203598a12.3
        for <bpf@vger.kernel.org>; Sat, 05 Sep 2026 23:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788676857; x=1789281657; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=KdaKawNfM+Y7YI0XikNKvnKD6zOewmI7dGL6oFhnGaU=;
        b=EQNIrAuBrq+vOF6uXO57Qgsd7c6aX9ERAsxWsDYdbBS06iosMASXijzposxEAMGcUm
         mA7X5x2TdlDrhgaFxeCApJDaNQJ/z6+sHwzO6ndPs/JtSzWeO5Lerr+UZJT6yqfKDnQA
         JJuhYVFbMU0TtWbVfu8MdPqlZ4ViZUMJJdJu31/o4hgKwJ+yg3PupaJkqMeH+EyARn6l
         sFxsPA9CzzH6uvmSziLWrvleNlwK4GPt2ABXW/KgsZ+AdfJ2OsuC8gempxv4Rxl/gY0H
         Mh4EceG9hxXg4AWEgiuVaRyFrDvtTrZQp7vcFbKTDwKOd5TCSv8m3UeQgpky7kS9XPIe
         zL3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788676857; x=1789281657;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KdaKawNfM+Y7YI0XikNKvnKD6zOewmI7dGL6oFhnGaU=;
        b=qPiYqL235aAbet4CRmzD0xHyBCxbRGN5NUVuDj8kMRCyLutf73AcMxSC6ByUY+1rtU
         S7ZuYZW4FhM0zplpmX7b9uawR7HSBDWYpegV1yTZu70ygyLGD85ETkNEldzdS9ebtwAq
         xG5HVOzVfs358UW93V0D0OShhiWBBn+jw3+JxQT6aPSzd5fbmUlDmF5umzjSmDszPYJC
         V3K+abHigJIOLok1KBJPSzk5fImm6tNswdc0vU7/kb1tQf7H4kRxx/RkrJ+QFt7xOMKS
         Pxw0nK6PnGtqaGaXjMVu+mV0Wxc8aQYhRjKF5IQIWx3PA137gsAnVDDNWFjhiM7+THPO
         FkCw==
X-Forwarded-Encrypted: i=1; AKwUvBzBc1iNZn1N88hPpO7nhnVP8PWvNshFU67idqK8WmJC/X9l4nYetOTa5xS1i4POPECNDss=@vger.kernel.org
X-Gm-Message-State: AFuF++mOm06daK+ddXx5yz9e/0jp6LmjDIG3+8jCkrfMFsXNQbFDkk2e
	RFM7Zp+i+gJ4Mi0O9mb7UVirtLXQEm+vOjD+3Q1Xg9dSBqf7WsFa8QAW
X-Gm-Gg: AYBFou2r0ym1FwdVdcWrQ52sTyM4E16DVnrlire+VIOt6cVDRnsxJZ+2KsSflVbv5/I
	H8pJPPMAr8S9kAP1bthnIaKXFVF6LZy0vpVZuJXjlYqlpIIsncaJBLHxXnYkx3n+WDiVMDEBXit
	06adEK0/lIbAwPqx0K/Z3Mh0eE1TvWXOg9/r5IyiTU94KhOfZnTvbALvV7haFbnlPotoEPgkyms
	EvjXaS82HDgts3h2bP8otIA75ogkl2vp4K1ObfEiBqpzCRexQakmyEkC6cuX43buwMjTiq5Ztgt
	EY6p7VM9Gpt/Bg8iRqc5UknP5LRoNQmHW6o6zUemB7mwvDtcp7N/+xacfzcO6rAg4yJyDowCr9I
	gHSFbKwJ993FVXCxrMgIO4q0KQdAZNp2Avp6wogk4HNgAbRl3gjm/qXCiGKFlLxkDA7f7/HEi4B
	B4VMV+u+aW6RP+7NHBNhLOq5lCT7XN7htVDHHLd6MXZxEasBFDRJpc47QUFTMnx8dRM0EF4KlKD
	44BBwHWkf1Y545u
X-Received: by 2002:a05:6a21:3942:b0:3cd:a1e2:f238 with SMTP id adf61e73a8af0-3da39fd2f21mr24533354637.16.1788676857030;
        Sat, 05 Sep 2026 23:40:57 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc45a6abaa2sm2412778a12.23.2026.09.05.23.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 23:40:56 -0700 (PDT)
Message-ID: <83e2ad1e23774de204372c7e3d3bddc8f570c099.camel@gmail.com>
Subject: Re: [PATCH bpf v2 2/7] bpf: Preserve packet pointer class
 displacement in regsafe()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Nicholas Carlini <npc@anthropic.com>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Emil Tsalapatis <emil@etsalapatis.com>, 
	kkd@meta.com, kernel-team@meta.com
Date: Sat, 05 Sep 2026 23:40:53 -0700
In-Reply-To: <20260905083418.3723623-3-memxor@gmail.com>
References: <20260905083418.3723623-1-memxor@gmail.com>
	 <20260905083418.3723623-3-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10+b1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-09-05 at 10:34 +0200, Kumar Kartikeya Dwivedi wrote:
> regsafe() maps packet pointer IDs between states and checks that each
> current register range is a subset of the corresponding explored
> register range. It does not, however, preserve the displacement between
> registers that share a packet pointer ID.
>=20
> This is unsound because packet range is shared by ID. A bounds check on
> one class member updates every member, and a later access can consume the
> range through another member. Commit 022ac0750883 ("bpf: use reg->var_off
> instead of reg->off for pointers") folded the fixed pointer offset into
> r64 and removed the old off equality check, so two individually narrower
> registers can prune even when their displacement has changed. The
> explored path can then license an out-of-bounds packet access on the
> pruned path.
>=20
> Requiring equal r64 bases would prevent the bug, but would also reject a
> safe uniform translation of the whole class. Instead, record the base
> translation seen for the first packet pointer in each ID mapping and
> require every subsequent member to have the same translation. This keeps
> the relative displacement invariant while retaining pruning for uniformly
> translated classes. Packet pointers without an ID remain unaffected.
>=20
> Fixes: 022ac0750883 ("bpf: use reg->var_off instead of reg->off for point=
ers")
> Reported-by: Nicholas Carlini <npc@anthropic.com>
> Suggested-by: Nicholas Carlini <npc@anthropic.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

So, essentially this is the same problem as `id + ADD_CONST` tracking
for scalar values, where the actual difference is stored in `delta` field.
In other words, that would be an undo of 022ac0750883 for packet pointers.

What about the original suggested fix:

            /* id relations must be preserved */
            if (!check_ids(rold->id, rcur->id, idmap))
                    return false;
    +       if (rold->id && rold->r64.base !=3D rcur->r64.base)
    +               return false;
            /* new val must satisfy old val knowledge */
            return range_within(rold, rcur) &&
                   tnum_in(rold->var_off, rcur->var_off);

Is it that bad?
Given this logic in adjust_ptr_min_max_vals:

    case BPF_ADD:
        ...
		if (reg_is_pkt_pointer(ptr_reg))
			if (!known)
				dst_reg->id =3D ++env->id_gen;

I'd expect it to be okay.

...
