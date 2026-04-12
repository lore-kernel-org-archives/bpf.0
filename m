Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D856201113
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 16:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776012591; cv=none; b=fWhQfyYpY6DqsteB9Maimc6GPKrp+8k5ROxqEx5w9WuXyXL8qJ3h41MwphbJ6V7PfjK+iBTesItvpMkxVpe9mysiAAyww62+aLKYV4nDymWVGli8NvyBSMeTYyWA1lsRsK60ott2M2bSoVPmVYRE+uv0tkb7SqQ5w5KqOP049s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776012591; c=relaxed/simple;
	bh=tU8jo4XTCUCI2ZGFMFkO+p79dGWiby/BbWrws6AtFCc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=gfvOYeaYOY7s1s93CI+UAvq15VNsKCIyesFYtAI+Ozo0Oe7Hws5C/loVFBsMFjhXr6nyuNF1PkhKOeQ7QGhxf65gSPmq7IQPO/8a+8qNiSb6qAzNybHl5qI4OqZsMebh2BixL8WvphdW1I1FH/dSkYzzKpzrjJfEZHIaDJEK3aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=cngGQEya; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="cngGQEya"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b2d3a9e149so8779725ad.1
        for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 09:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1776012589; x=1776617389; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZmbeA02L6exl5egKvH928KPLRjp+rj1JtvjgeezeIrc=;
        b=cngGQEyaF6GgqrCJn6O8EQRTl4jKYYZsvGCNV6m/7TqHOm9EptSIZBowSgGjDW6tBk
         6XMmLRSxJoVZe0ztqW/tT06koZCYi6TzqL4ePI646vFLqeHaOMpp8kFgdMzzZz5xmKQg
         fEG8TPj3TDEUGhLNGug3ooGrsq8xjYbG1YfOyUadb174oVOsu78aVGzSO7ZjfcGxAwuU
         u7z8vf06ctUKAt+oQVkiQCeSC/O1hUgYwUTKfiTozBA6d2hobgBGDEUXzUzZxGuWzvjj
         40hYwD5mOcuKc6zhZx9SR9jeV0rh9g27BPAvayHjjmxpQupCwmeYzCsMAAeOhC6hK1jM
         LaRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776012589; x=1776617389;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZmbeA02L6exl5egKvH928KPLRjp+rj1JtvjgeezeIrc=;
        b=OL4RA9UNQKBOSzJ/+p6a5W8HjJYrZHNqzfIx3k68q8A4hxpiCudMtDxPEff72kNDr+
         3z0xrTuTJoaJgcDc3zOsesQ0DF1yBoLjDtp3GvGoItHryY4dRezmhPILmmwAOgkTKVuZ
         u/0rgyl+kf9SPIU00Y5xmiC3i3nVOnBqbV5eebeZlrhah5EBtAHSbEA/zVg+LjHLn6fu
         pzdgrRCEBaA0apUjd0WDXw5ZxHtf49CqbstgIiRdJ1pWTvFWvjN5ESNs0xcggMiXBKtp
         wHhz8rhjtIUje/cLMfuZUtjshFIcp1UJQ6DoN2Zaz1MmG9a+y0p0Ky1W5ggFR5BJ4tqt
         wxaQ==
X-Gm-Message-State: AOJu0YwlGkQD8d6kq2P57tCP1XETKIVzSzAegC98DLWOC1tVv0qGtfFj
	5Vw3VL/YnHwjCyc6tVNyKdgdtMZj/QfRPGCgeQy0ihXtYAH6lnPlDbvsLC2X09bLWEw=
X-Gm-Gg: AeBDiesU9tRzgbiTzkrX86c44+UIRrW+iHpQ7F1RNWEwtUsey2HdmEsAlqIt8SeLBZM
	37jFwi6ZNeec4P+nmnadKMts8fr3czBLjqDI8FA/oYE1Jf08HCVrWHqwrRUTmYmQFfWMxjKwBsP
	OzTymUl3Q/B9+EARaBQOHPsVIEDgCb5zNbA1RTAh2cpU/XSRcFBL127j1SZA30eRsHtnPOMJAuO
	WqORwhT9JtveInX7/MSAzjNh+60ok9OlS1VSC8YIYSB9mjVvLxzORUQKw7P+URgAkHnhrtiANOB
	LqqD0XAOoNqKzALQxhgi9WgeSt6pkZYIS1LvGdlM7gkOjJ00sobKOmTtdLt9PBBcvoulAXLBjWk
	P4ZH6fCjhAxSrrrFbhvBMk1oVNEvaXVtzIuO3lgbSqNeyDMQOU6/hnyH9Sx41pQaRfgNxPDwJgV
	lvr/aCnzE=
X-Received: by 2002:a17:902:ffd0:b0:2b0:4f16:22f7 with SMTP id d9443c01a7336-2b2c73474b0mr124337905ad.16.1776012588791;
        Sun, 12 Apr 2026 09:49:48 -0700 (PDT)
Received: from localhost ([2604:3d08:487d:cd00::5517])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b45f6c0219sm4339435ad.10.2026.04.12.09.49.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Apr 2026 09:49:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 12 Apr 2026 12:49:47 -0400
Message-Id: <DHRBX3BODS5E.YMM5PVBHLRNB@etsalapatis.com>
Cc: "bpf" <bpf@vger.kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Daniel Borkmann" <daniel@iogearbox.net>, "Eduard"
 <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>
Subject: Re: [PATCH bpf-next v6 1/9] bpf: Upgrade scalar to PTR_TO_ARENA on
 arena pointer addition
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, "Emil Tsalapatis"
 <emil@etsalapatis.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260412011857.3387-1-emil@etsalapatis.com>
 <20260412011857.3387-2-emil@etsalapatis.com>
 <CAADnVQK_Ze+WZAJvyT0Dn3v8QgLWcjD6sS9b2ZqKYW0i1y2VZQ@mail.gmail.com>
In-Reply-To: <CAADnVQK_Ze+WZAJvyT0Dn3v8QgLWcjD6sS9b2ZqKYW0i1y2VZQ@mail.gmail.com>

On Sat Apr 11, 2026 at 9:58 PM EDT, Alexei Starovoitov wrote:
> On Sat, Apr 11, 2026 at 6:19=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis=
.com> wrote:
>>
>> The compiler sometimes stores the result of a PTR_TO_ARENA and  SCALAR
>> operation into the scalar register rather than the pointer register.
>> Handle this case by upgrading the destination scalar register to
>> PTR_TO_ARENA, matching the existing handling when the destination is
>> already PTR_TO_ARENA.
>>
>> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
>> Acked-by: Song Liu <song@kernel.org>
>> Fixes: 6082b6c328b5 ("bpf: Recognize addr_space_cast instruction in the =
verifier.")
>> ---
>>  kernel/bpf/verifier.c | 73 ++++++++++++++++++++++++++++++++++---------
>>  1 file changed, 59 insertions(+), 14 deletions(-)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 9c1135d373e2..1aa60199fa2e 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -16640,6 +16640,59 @@ static int adjust_scalar_min_max_vals(struct bp=
f_verifier_env *env,
>>         return 0;
>>  }
>>
>> +/* At least one source instruction register is a PTR_TO_ARENA. */
>> +static int adjust_ptr_to_arena_vals(struct bpf_verifier_env *env,
>> +               struct bpf_insn *insn, struct bpf_reg_state *dst_reg,
>> +               struct bpf_reg_state *src_reg)
>> +{
>> +       struct bpf_insn_aux_data *aux =3D cur_aux(env);
>> +       u8 opcode =3D BPF_OP(insn->code);
>> +
>> +       /*
>> +        * If it's an instruction with an imm operand, we know it's vali=
d
>> +        * because we checked in the caller if the destination is
>> +        * an arena.
>> +        */
>> +       if (!src_reg)
>> +               goto valid;
>> +
>> +       /* Ensure both operands is either PTR_TO_ARENA or SCALAR_VALUE. =
*/
>> +
>> +       if (dst_reg->type !=3D PTR_TO_ARENA && dst_reg->type !=3D SCALAR=
_VALUE)
>> +               goto error;
>> +
>> +       if (src_reg->type !=3D PTR_TO_ARENA && src_reg->type !=3D SCALAR=
_VALUE)
>> +               goto error;
>> +
>> +       /* If dst_reg wasn't a PTR_TO_ARENA, it is now. */
>> +       if (dst_reg->type !=3D PTR_TO_ARENA)
>> +               *dst_reg =3D *src_reg;
>> +
>> +valid:
>> +       dst_reg->subreg_def =3D env->insn_idx + 1;
>> +
>> +       if (BPF_CLASS(insn->code) =3D=3D BPF_ALU64)
>> +               /*
>> +                * 32-bit operations zero upper bits automatically.
>> +                * 64-bit operations need to be converted to 32.
>> +                */
>> +               aux->needs_zext =3D true;
>> +
>> +       /* Any arithmetic operations are allowed on arena pointers */
>> +       return 0;
>> +
>> +error:
>> +       verbose(env, "R%d %s R%d: Invalid operation between "
>> +                       "bpf_reg_state types %s and %s\n",
>> +               insn->dst_reg,
>> +               bpf_alu_string[opcode >> 4],
>> +               insn->src_reg,
>> +               reg_type_str(env, dst_reg->type),
>> +               reg_type_str(env, src_reg->type));
>
> You went the wrong direction here.
> The current verifier allows arena +=3D ptr.
> So be it.
> The resulting arena pointer is still safe.
> It's probably meaningless, but the verifier shouldn't judge.
> It's job to prevent crashes and not logical errors.
> So revert to previous code and drop !=3D scalar check
> and fix the actual error, since two reg_type_str() are wrong.
>

Ack, this version is doing too much. I'll drop the check next
version. This also removes the verbose() call so it resolves the
reg_type_str() issue. Since for v6 the only Sashiko comments
left are debatable and/or nits, next version will be a fix of
this patch, adjustments to the patch 2 tests to reflect the
updated patch 1 semantics, and removing an unnecessary header
include from patch 5.

> pw-bot: cr

