Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B0213C8E8
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 03:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775445199; cv=none; b=VZT9KGSNFd2CfO3hlvLPY++5h6QxgppUCL164yiLXUuXxR60cZQQBs9p3ZG0rbzs7J39aeZto6MMZH5ziOhTapkoBS03R4/9iY5rbmw0pFBdyL1JAgL+UJfi87+Oxi3KrfH5y2cWY/LRGmaf7i5E+LKkkCmwTJjOjHLw2lbH0Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775445199; c=relaxed/simple;
	bh=yQGImmrjwLYeGHdVX82wTBnt/uEq+A862pqBtuQLX+E=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=B9vnnoZRrgBqBw4Rj2oSq1is2utrUq30n6xXiO3jhEIoeKAPmpTO75Abz/8zM60gvOfEI7ZUyMEB5UkIgg71cQncSZrkW9tuhz1MQEVzKO6qQ45Vpdo7b9IeZMI2UK5kvgr/KkFwrtHs5Elxh89GhCcqcZ4z9Z/8CM4buLf73aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=CNdGFAji; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="CNdGFAji"
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-c76c60c7502so1253958a12.0
        for <bpf@vger.kernel.org>; Sun, 05 Apr 2026 20:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1775445197; x=1776049997; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WikSyXf56QgGRlPo6LAXPYCmBwFl+zDorUSabvFaPsQ=;
        b=CNdGFAjiwyrUvwB+aqH/zLS0WZQHfTuwaJZHQWqX3cMG1WQWWIlTZ6Z8Xue/HuUO/y
         d/J09JaQjUpm3usDcTCS0Q4GQU5GzxU7fBbo8yxAMow7ykx2UgDlStCzaxNR9ZtgCdoW
         mtVxqePweiSZ734IYp7b8VvCDMhfqTKgOxpzvEI6tkZFunc11xU1GX3LSakZeU9Qv+og
         DelJRxldSSyq05LS1LgcOWRaRRndsZXcs6pHXCROck1OM/ahJvqkrJg8BGxF24dLn4jY
         NOgm6Vh8DJSCE+zP6W2cDmSmtr/r31YWgNsAD2uqNujzqg2iG9Y4qamHiMQC57eBdeJj
         Z5Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775445197; x=1776049997;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WikSyXf56QgGRlPo6LAXPYCmBwFl+zDorUSabvFaPsQ=;
        b=qsg78+jeFiS6vdewz6G/aEeMhqYPoVYW1KDDDvFu3Etssyf6zN1KlrGC4gPgdvrMV7
         SYJ3+PQGM2bIY5V3YY1aDNzftTpeneO/p1lXQ6PWi9l6ZZ/tMgXxnFwlwoXRY50ejA1m
         x/x84eKa4fKAb79LbpdGhrAp/a2YmDK8qQsRy+dvARjyoxKd1yc7q1+Fp+1Kn+K1JVBp
         iLuqDBJ0nb5NKXHItOEsQYMhMCMELvXAvLwQ0N3VHOsZbOm5KcHupZJBULCmRT37utZZ
         Q5jsw4HpqI/2lJN3cpjoQjq1FWcbNMDsfoBSRt0bbupJ1piGg8pvJdhQQLJ3LUKjPReW
         kWiA==
X-Forwarded-Encrypted: i=1; AJvYcCV+F2V6IsoK/eKYM/onsqyI3ILheT+obNhipHu4s23s+WfXoTQmmUShoCcLvLeyuN0CcKE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz94nJienQaZxlIBzdz5Z2OkTHiKqaWzJ+W+J34YvtL+Fvof0Q3
	ihOnSQq/fPdeTG4MRT8dmavzYneJ8GybeyBcNLk9PQjWHIdaFVvhm2FE7uFhytzvrRs=
X-Gm-Gg: AeBDievKauzTazRThkcN9hzdK7EMr9p3+QvvDwHlsx6hqIo8/+X3jFp0j55KzBcpTGB
	sSClHFCFnGf6ttzvAqpOOotEFW3GOkeuGCY8JChQOfEUd+H8l5ZGwHxpI3Azmx2J5QU2wZWdoBR
	yU1q3mX10kJ4n05atuZylUOW6R7XRmYt6UBPOUU0iA4yJPm8kCSqI7s2TfLXxf2l6h3hg0Gvw4l
	zO2yKrDCetPPZHpSqeUz5ziRrS1sqkBabAR5U2c20pnq4/b+7zGYXp6QO/36zAPbUBUlrOiIOyX
	QY32w1xydDMKLLU+03octukcgvw/q/Sm/PXb9RKpbuahO05agLpb/mcPaQ3KxLDVWdB4BCPAqdu
	GPrSwJ3wp5ic2JmVFc9RmgNjeOj5VQkLWESrThKd7wKtGkEWxYd3C9m+PWYcnP6le/hDOsVWwec
	pks0jxlG8=
X-Received: by 2002:a17:903:946:b0:2b2:5293:f415 with SMTP id d9443c01a7336-2b277d8ba21mr124434045ad.7.1775445196985;
        Sun, 05 Apr 2026 20:13:16 -0700 (PDT)
Received: from localhost ([2604:3d08:487d:cd00::5517])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749cbd85sm119417275ad.74.2026.04.05.20.13.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Apr 2026 20:13:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 05 Apr 2026 23:13:15 -0400
Message-Id: <DHLQSMYH2MV0.3ROVQ0ALRBIW6@etsalapatis.com>
Cc: "Quan Sun" <2022090917019@std.uestc.edu.cn>, "Yinhao Hu"
 <dddddd@hust.edu.cn>, "Kaiyan Mei" <M202472210@hust.edu.cn>, "Dongliang Mu"
 <dzm91@hust.edu.cn>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "John Fastabend"
 <john.fastabend@gmail.com>, "Stanislav Fomichev" <sdf@fomichev.me>, "Alexei
 Starovoitov" <ast@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "David S.
 Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, "Shuah Khan" <shuah@kernel.org>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf v1 1/2] bpf: Fix SOCK_OPS_GET_SK same-register OOB
 read in sock_ops
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260404141010.247536-1-jiayuan.chen@linux.dev>
 <DHLMGWNKBI4K.3LM87NOU4XB3O@etsalapatis.com>
 <DHLMKFBINRKW.BS0BEK9AMU86@etsalapatis.com>
 <346597fc-1703-45d7-bcef-55f5d4a7579c@linux.dev>
In-Reply-To: <346597fc-1703-45d7-bcef-55f5d4a7579c@linux.dev>

On Sun Apr 5, 2026 at 10:58 PM EDT, Jiayuan Chen wrote:
>
> On 4/6/26 7:54 AM, Emil Tsalapatis wrote:
>> On Sun Apr 5, 2026 at 7:49 PM EDT, Emil Tsalapatis wrote:
>>> On Sat Apr 4, 2026 at 10:09 AM EDT, Jiayuan Chen wrote:
>>>> When a BPF sock_ops program reads ctx->sk with dst_reg =3D=3D src_reg
>>>> (e.g., r1 =3D *(u64 *)(r1 + offsetof(sk))), the SOCK_OPS_GET_SK() macr=
o
>>>> fails to zero the destination register in the is_fullsock =3D=3D 0 pat=
h.
>>>>
>>>> The macro saves/restores a temporary register and checks is_fullsock.
>>>> When is_fullsock =3D=3D 0 (e.g., TCP_NEW_SYN_RECV state with a request=
_sock),
>>>> it should set dst_reg =3D 0 (NULL) so the verifier's PTR_TO_SOCKET_OR_=
NULL
>>>> type is correct at runtime. Instead, dst_reg retains the original ctx
>>>> pointer, which passes subsequent NULL checks and can be used as a bogu=
s
>>>> socket pointer, leading to stack-out-of-bounds access in helpers like
>>>> bpf_skc_to_tcp6_sock().
>>>>
>>>> Fix by:
>>>>   - Changing JMP_A(1) to JMP_A(2) in the fullsock path to skip the
>>>>     added instruction.
>>>>   - Adding BPF_MOV64_IMM(si->dst_reg, 0) after the temp register
>>>>     restore in the !fullsock path, placed after the restore because
>>>>     dst_reg =3D=3D src_reg means we need src_reg intact to read ctx->t=
emp.
>>>>
>>>> Fixes: 84f44df664e9 ("bpf: sock_ops sk access may stomp registers when=
 dst_reg =3D src_reg")
>>>> Reported-by: Quan Sun <2022090917019@std.uestc.edu.cn>
>>>> Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
>>>> Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
>>>> Reported-by: Dongliang Mu <dzm91@hust.edu.cn>
>>>> Closes: https://lore.kernel.org/bpf/6fe1243e-149b-4d3b-99c7-fcc9e2f757=
87@std.uestc.edu.cn/T/#u
>>>> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
>>> This patch only seems to fix the problem when dst_reg =3D=3D src_reg.
>>> Why is this not an issue when is_fullsock =3D=3D 0, but dst_reg !=3D sr=
c_reg?
>>> In that case the dst_reg is unmodified by the whole macro but is still
>>> marked as PTR_TO_SOCKET_OR_NULL. Isn't that a problem? Can you add
>>> a test case for is_fullsock =3D=3D 0 but dst_reg !=3D src_reg in patch =
2?
>> Sorry for the double post, but also check sashiko.dev:
>> SOSK_OPTS_GET_FIELD seems to have the same issue as the
>> SOCK_OPTS_GET_SK. Can you add the same fix to it?
>>
>
> Thanks for the review!
>
> The AI reviewer's observation about SOCK_OPS_GET_FIELD() is correct =E2=
=80=94
> it has the same bug when dst_reg =3D=3D src_reg and is_locked_tcp_sock =
=3D=3D 0.
> I've folded that fix into patch 1 in v2.
>
> Regarding dst_reg !=3D src_reg: this case is actually safe. When
> dst_reg !=3D src_reg, fullsock_reg is dst_reg itself, and the generated
> sequence is:
>
> LDX_MEM=C2=A0 =C2=A0dst_reg =3D is_fullsock
> JEQ=C2=A0 =C2=A0 =C2=A0 =C2=A0dst_reg =3D=3D 0, +jmp
> LDX_MEM=C2=A0 =C2=A0dst_reg =3D sk
>

Yes, I missed the dst is the is_fullsock_reg assignment. v1 looks
correct then.

> The JEQ only branches when dst_reg =3D=3D 0, so dst_reg is naturally
> zeroed on that path =E2=80=94 no extra MOV_IMM needed. The same-register =
bug
> exists precisely because dst_reg =3D=3D src_reg forces the macro to borro=
w
> a temporary register for the is_fullsock check, leaving dst_reg (the
> ctx pointer) untouched.
>
> I will add a get_sk_diff_reg subtest in v2.
>
> The other suggestions (moving the detailed comment to the BPF program
> file, avoiding vague "the fix" wording) are good points =E2=80=94 address=
ed
> in v2 as well.

With the changes, feel free to add to both patches:

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
