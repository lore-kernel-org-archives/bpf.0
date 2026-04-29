Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72A310F2
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 00:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777421257; cv=none; b=mW6GCoffq/bhRQJNzl0v8gvoi/Qnyh1bkAs52G+Gzk783ET7XYnXWkMBmjFjNieDf5ahFU9Vw1OnZdrJXESgqTCfEiG8J2cuydz65BbxlEm565cvuhRL4reuw2wGefsRHAGtkFP0uX3TjSTfUpnKLP06y4PMD8RDkfvISFJELe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777421257; c=relaxed/simple;
	bh=S8Rsy8kprKwgRoCddvTdZx2hz3GL81C33X6Tlw7SFNs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=EjLHHP+T+zonLN0DxcGERfU7IZKfr+6Pcbt+lXrdefT4D/ctEV83j7sx6XLCkS9MlWcVTqLO7WStnphHJuddLBPtI8ag4DtumrCh1lSm44o06eZf8DD4JqIBuhBuIsEXR3erJVvki4cUaW3fKXblhu6ZxSqLxGYmlpA2AavHt4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ADL72UXJ; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ADL72UXJ"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-488b8bc6bc9so86022635e9.3
        for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 17:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777421254; x=1778026054; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ACfb+/M+FYTSNEh0C02o5v+IVIBAx4mi5YgLpUoGiKk=;
        b=ADL72UXJbXsMeDJT5OIzDtGwVsxERYEyR/5qNKfHrWwk52iDobOYNI+uQ4AnUAZ/IJ
         1sOlZTHDjEB5xJldxWF9X8N4PLdj6MYs2nlIIslh9nbUAth9VWEErQkQahSwCb0yRJhh
         Rvfcd2eS1HJ46AbAQ/MTtyxjvU3RILijyhxVDbiD06lgFHSk7y4S4RFYfWLENgMY0ynC
         5Tuv20sKGOqwj2dlhRxJspE87T0Qb2UbaVsbKznDoULViW3H+HXOitanmD07ewIjMBP4
         I1mo3MIyqHlWProWI5VYq+8blqGTwBKQge7DRMPa2RVNBx/qcFzav/pYsXMJoExad8fs
         iTxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777421254; x=1778026054;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ACfb+/M+FYTSNEh0C02o5v+IVIBAx4mi5YgLpUoGiKk=;
        b=g9Oy2Y1q8uQit2AA+DLNNImHZ+o/3njMHVYu3IH8li5B7Ijg7t7SWq1LV2DcXicbzG
         VqsC9aY4eqTbq5I7Y5VCopRWT+KAY3hv0Pgyz8Es3WRrcVwGyVcL/pvYypuakEJ2k2Fv
         QXyfI0Qq/wcsMX/osjyiZtjIqd/TUDYzpzKpMqk/6mb24Gb1JqD0lXFFqVYQ9KlvaL72
         xWvge2Vk5zdHJ88n2m9V5bbQGPJeYnrmcU5PC4JRMCBZMdlRIzl0obV8lorO2wKkfs0e
         ZGz0oMak0eZXliKSdG8ANcF+4y55bdchOtJZto05RV7rnQGSSKLUVCQ8whYUTRq2/UeB
         QTOQ==
X-Gm-Message-State: AOJu0Yyloe/WUWuWG2mnEOPw7MEBfYF2HzARY2C2NT7KhA9tScA7zqK2
	knIxpfLcRF047dvtYNshuN1huIadZQoDYKOymHVAUman64rTiTgkIlO/
X-Gm-Gg: AeBDiesux4u9ljA50jWyicRaVj8oId3660GzMof1IQCSEwNNU+KWjDNu7evIfkivx9/
	3QnaokMr15fehVnk1oZK+LmT488sUfCSmVs6xTfOW3jLPqsaHtX02h1PJrHFcShV93/rZ2fBYlN
	H8XSiqU/6Wst44tKGIuzpRXajLJs6HGy+h7y60l/PCSouQDP6u3Nrr4S8ZXP3/avXgAncNOIwaU
	RRdvlbi15xHrw5z2ytsS61s+iMT5RlpCe7M78NuHhFs0WHQ5l+WSLAVareW2FqZs9HhElei4o8+
	O+BZyk6qyKPzoMfJ+ysOhhDKao0KHIn8Uuo0xHo7i9yYnHbGxA2NklQ6MQtR72gkfR5EWTs08IO
	1GfTCYzYtVY/zzLXcH4ccOfPPdb/QeqKqBf9A5RuDYTqE7XderOXAZgrLn2bGGgNuhDocsWws2j
	XXBPgoYeln0JtaAXpTgEuJAC8Vyvrrsmi9677jgu5lINI46e7aiXysZuxBnXe3BTekmN4vH57fu
	OvTSCNmkCS4vO5t2N2zcfCPgE3aKDqoMCoEEJ/TdKDhpKDruzhnh00LVS+cTgBeYoRvrOMDpvY/
X-Received: by 2002:a05:600c:630a:b0:486:fbd1:9dc0 with SMTP id 5b1f17b1804b1-48a77b19d7dmr98636755e9.22.1777421254032;
        Tue, 28 Apr 2026 17:07:34 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7c5845c8sm13224245e9.7.2026.04.28.17.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 17:07:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Apr 2026 02:07:33 +0200
Message-Id: <DI578ZDDKR6K.QH52KXPV1CLN@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Print breakdown of insns processed by
 subprogs
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, <sashiko@lists.linux.dev>,
 "Paul Chaignon" <paul.chaignon@gmail.com>
Cc: <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <5c3514dbc879f22ba3f9eff8a2c730e13bd0572c.1777388107.git.paul.chaignon@gmail.com> <20260428230844.EFA64C2BCAF@smtp.kernel.org> <DI56ZVH6HKDK.1L8J5HPA37J09@gmail.com>
In-Reply-To: <DI56ZVH6HKDK.1L8J5HPA37J09@gmail.com>

On Wed Apr 29, 2026 at 1:55 AM CEST, Kumar Kartikeya Dwivedi wrote:
> On Wed Apr 29, 2026 at 1:08 AM CEST, sashiko-bot wrote:
>> Thank you for your contribution! Sashiko AI review found 1 potential iss=
ue(s) to consider:
>> - [High] Out-of-bounds read in `bpf_subprog_is_global()` when printing v=
erification stats for programs with hidden subprograms.
>> --
>>
>> commit 08128f883e58301e0f97b1d4a94656be63b8f790
>> Author: Paul Chaignon <paul.chaignon@gmail.com>
>>
>> bpf: Print breakdown of insns processed by subprogs
>>
>> This patch tracks the number of instructions processed by each global
>> function (subprog) during BPF verification. It then reports this
>> breakdown in the verifier logs under BPF_LOG_STATS.
>>
>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>> index 03f9e16c2abe..b48389b48eb6 100644
>>> --- a/kernel/bpf/verifier.c
>>> +++ b/kernel/bpf/verifier.c
>>
>> [ ... ]
>>
>>> @@ -18288,6 +18295,13 @@ static void print_verification_stats(struct bp=
f_verifier_env *env)
>>>  				verbose(env, "+");
>>>  		}
>>>  		verbose(env, "\n");
>>> +		verbose(env, "insns processed %d", env->subprog_info[0].insn_process=
ed);
>>> +		for (i =3D 1; i < env->subprog_cnt; i++) {
>>> +			if (!bpf_subprog_is_global(env, i))
>>
>> Could this introduce a regression due to an out-of-bounds read on the
>> func_info_aux array if there are hidden subprograms?
>>
>> At load time, if BTF is present, env->prog->aux->func_info_aux is alloca=
ted
>> with exactly func_info_cnt elements, and env->subprog_cnt initially matc=
hes
>> func_info_cnt.
>>
>> During verification, if a feature like bpf_throw is used without an expl=
icit
>> callback, add_hidden_subprog() is called which increments env->subprog_c=
nt
>> but does not resize the func_info_aux array.
>>
>> Since this loop iterates up to the updated env->subprog_cnt, when i reac=
hes
>> the index of a hidden subprogram, bpf_subprog_is_global() will access
>> aux[i].linkage where i >=3D func_info_cnt:
>>
>> kernel/bpf/verifier.c:bpf_subprog_is_global() {
>> 	struct bpf_func_info_aux *aux =3D env->prog->aux->func_info_aux;
>>
>> 	return aux && aux[subprog].linkage =3D=3D BTF_FUNC_GLOBAL;
>> }
>>
>> Is it possible to skip hidden subprograms here, or limit the check to
>> func_info_cnt?
>
> Don't see it happening, since hidden subprogs never get verified, so we w=
on't
> invoke bpf_subprog_is_global() with such a subprog index.

Ah, no, stupid me. We get here after fixing up and adding the hidden subpro=
g. So
we can still do OOB since subprog_cnt includes the hidden_subprog_cnt. How =
about
the following as a fix? I checked over other places where we iterate over a=
ll of
the subprogs and those look fine, so instead of changing bpf_subprog_is_glo=
bal()
we can adjust this function to only consider real subprogs. Didn't compile =
test.

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b48389b48eb6..b9266e3d46c7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18281,22 +18281,24 @@ static int do_check_main(struct bpf_verifier_env =
*env)

 static void print_verification_stats(struct bpf_verifier_env *env)
 {
+       /* Skip over hidden subprogs which are not verified. */
+       int subprog_cnt =3D env->subprog_cnt - env->hidden_subprog_cnt;
        int i;

        if (env->log.level & BPF_LOG_STATS) {
                verbose(env, "verification time %lld usec\n",
                        div_u64(env->verification_time, 1000));
                verbose(env, "stack depth ");
-               for (i =3D 0; i < env->subprog_cnt; i++) {
+               for (i =3D 0; i < subprog_cnt; i++) {
                        u32 depth =3D env->subprog_info[i].stack_depth;

                        verbose(env, "%d", depth);
-                       if (i + 1 < env->subprog_cnt)
+                       if (i + 1 < subprog_cnt)
                                verbose(env, "+");
                }
                verbose(env, "\n");
                verbose(env, "insns processed %d", env->subprog_info[0].ins=
n_processed);
-               for (i =3D 1; i < env->subprog_cnt; i++) {
+               for (i =3D 1; i < subprog_cnt; i++) {
                        if (!bpf_subprog_is_global(env, i))
                                continue;
                        verbose(env, "+%d", env->subprog_info[i].insn_proce=
ssed);
