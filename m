Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B45237418D
	for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 20:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769632328; cv=pass; b=pXsfw3Px0vceu5wzjM9NLhUgIL+Jdd30AqXm3YkCFMVoJ78CEUbcuefzQJ1jMOKJrD2Eta5yMI2i1UIKjKl6DzUUJCuzi28Th58hr8ApVq7Xb1yl2FDOQVTVyipV7qdpuxRNxjYW1HOfvlohHXQFwgrl7kmnLOMgNZk8HBKtqLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769632328; c=relaxed/simple;
	bh=808hQIDw8HXuF8zg34i2s1I0VMLdN4AzGhcnwG8lblQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yl2QZZTzk0/WFG9nnpJssFPRZa8V3SPfHWI1S2z/50SA9dpEPhWkwRaPBLKAOMB2FPxJTkunpD3xsDuiTdbd5h9fEKifKhrr/MLrcr8Qu8kBN/Tti4BFGeh3blaT4ZyYfLfu/RZBiUstaIpmMLGx6JSSqZElr5Vz7BZpVziiTjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MUTgv8V3; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUTgv8V3"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43284ed32a0so150418f8f.3
        for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 12:32:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769632325; cv=none;
        d=google.com; s=arc-20240605;
        b=f5zNLx1wWZFTJybxN6JGyWXyP8Xxe2ySM6RFvYCOqXH0uvjzjJOxf4B0G4W+Jcls5x
         JdEm3jSGAWYp8rKdw+pCu3L/dOx/ceDDkSjUtRka/zcF3nB4eum12bOD0UF1VDW3ny7r
         9/EOjECupbqCaQT0FfKPOSat+0Z+7h/YBQXn7vyOIYS3tVK3/9Y1WAvrQLX/p+7ij3Tu
         FMm/FVZlq3L+R63Fq4NDz3pXVGyC+x3HEa2KJSKQTOSQNYL9gcLj195ZSsgxAclojAlJ
         zyHIKDRNz7G6GzzYkKybZqFxncLiD8FszpUiVbxEBfOuYdpMOCaemt9B845TxFsonTEK
         G4EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=07rf/uTuwqt/mx7z+xU8g3Kvog0c3ZDUc5m6W+iA6DE=;
        fh=z/MqJcPtlJEHbfUbPIEB2YZvPHdw8fKU8dtSobkgSjs=;
        b=Gi1RH/IgyWbA8yBfqUazNd0Md1+Y4y067pN/mdzuO5kkeWWEwocFlse0687N2DnL6m
         62lu5TqAeWNHpgLBy4057F0BoJt6l2NYBQ/7dBYVyNJ8Y2RoZ/VHBCQrSrHgTsaqIlsw
         g5Hq5RoHDCDSVzhvHFp5ITJ96ewpOcFPjeSvStvKkV/2a5Jktwk+orA/2YCH59jvIM0Z
         Wf2VWN6jRBifjRU0Z75CftgBKAh02EbxoqQP9SYHPlp/Yj2aFk8pfi3OA5ZlPtB3x+Z5
         +8ZMgjPqc6Z3clrcYnVelaPE62edyCM6+25YgZzZMms3j/x5Eg0GBxda4704zB5r7hzz
         6EyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769632325; x=1770237125; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=07rf/uTuwqt/mx7z+xU8g3Kvog0c3ZDUc5m6W+iA6DE=;
        b=MUTgv8V3qcslf2OJAwqMbqAa5Wc0GJYvnYwhfsYuSMreQAuFL1wkJElStmcg6+JqWW
         ZjJbhceLwllEP89QvD2JTFcvQyh0H1kNEp8dMUnZBouQoYkGac2l9RV1eyNOBQYWMRUw
         8V8mfsk6A7KTkN1dULpd0cnzMAF6M7xNkm+8nywZdBXlqfCsShOWCJym70VPz7EliIwA
         rYxEJNvGt2tlyrM+KIzQHLdVZ3wsZtRQI9nI8qVLhiWENd1tFlPHZ77Re6/jMWYjTzlc
         i65MrWoWBhvlHqNhsE6Fup6vgaQO4IU1eB1a8L7KPg6nxWtdMnEA3JnnjcRMoe30h/BT
         /0YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769632325; x=1770237125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=07rf/uTuwqt/mx7z+xU8g3Kvog0c3ZDUc5m6W+iA6DE=;
        b=juHgLl/ndJ9dwBO/yOGwVXK1o/K0ei3mtqgakDLI0YQBBwnvZH4f+9NlC5p2ugyzMO
         IU24BzHlsgFiEQUTng1V4nHIbAm057tCgCSTL/A+KBn67Q6Y8c+ZQ4Q+7EEuq05sQvGD
         tcUx2HTPcsNMqpPEsnb/23UHm8+ap5ngCfifRnV9djIyf8LZRsxPJv31dcnb6cJVLCvc
         qGwA0h1+wVb9/SLBkKeWHBEBhqu6ApZTSSSBRzB5+IJ3VBszRF7xF8g9dA/eQimnHPT7
         HL74t2A/vNBOzvAHOqgrge2k9ZPYc/UF+hLRPIWGoFtzAFdP2ki1B4Yd8yVvyeKax2qu
         bMGg==
X-Forwarded-Encrypted: i=1; AJvYcCXzTzM+F/qfDHVgQNH8iY2jk8IKTzCPIWIv02kNUPZFi1U3LeIQn2BkuIJYZW2ny+ZyId0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeJNjyWgarsyj4a8muDvgTezkhiiOzjChA/ctAKEsCwTr3wwIZ
	bhuTuvtq6l9nk3sJwLdiGh8nshEMlL9XqfE0g6p5WIiItVs9CodyVmJupzCA90PixHjNZv1E2YI
	W0GOpdVgzcxUnuWQiWli+jaQDDi1P+qQ=
X-Gm-Gg: AZuq6aIaz47y/zJiy8EujVFjMnzEdv2FwHvjX0o9kl0DID+p4LPTEwoNHWsrua8mS+K
	PpCHHhBWTUhS7oaqSmFfgW7UGL3im3KDjLOBKMtcF09gMYz48tdX8262bzbB1VcJgmJm/l59NC+
	j3l0khx7uVsqn4OeOJGkujZ/bszoX7tZCXAcLlp+o7AvWD8Y0XIev9FsF5FyOP76EyMAm7h83dd
	5A2Vt3mh12uJFiMJb/tiS1VmkzuvXXfnrwFQmfK3dP7gu5sHVriOXlA+4YlEa42fnshB3BN5dWN
	6kXgtWiOEeL36vBFr5mpCjy4ldNjwA2ipQdkj2augxGQj8U6LDpg9I7LBk/htgOjLO5MG8wNguA
	8uUCCEcN1siNk+w==
X-Received: by 2002:a05:6000:2404:b0:435:9653:e154 with SMTP id
 ffacd0b85a97d-435dd074b2bmr9812358f8f.27.1769632325304; Wed, 28 Jan 2026
 12:32:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128150112.8873-2-leon.hwang@linux.dev> <e64c4137e7f262e6fdab272e8ee44c8a129a36eb6d0186914375d6ba20d88474@mail.kernel.org>
 <65231eeb-1f00-4af2-9234-a290ea3f6585@meta.com> <a10afa70-29b7-48ab-b241-8b0f602abe2f@linux.dev>
 <CAADnVQJV=e2VgQzkpsUQwexhaVZMs7uXHCe1Fa6VwbVNUMPghA@mail.gmail.com> <7dbcc5d5-476b-46e5-9e4b-b260d24a51a1@linux.dev>
In-Reply-To: <7dbcc5d5-476b-46e5-9e4b-b260d24a51a1@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 28 Jan 2026 12:31:54 -0800
X-Gm-Features: AZwV_QieHaFto3G-1e8bEUtCESnVn4_ZZwARjehTdXUH1XxE0kv7X3Eh3iZgKp8
Message-ID: <CAADnVQKdZo4Qm0z-qedkfQHZhq+tW4MuRSzM5-zAGYX-ZQTiaQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/3] bpf: Add bpf_arch_supports_fsession()
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Chris Mason <clm@meta.com>, bot+bpf-ci@kernel.org, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Puranjay Mohan <puranjay@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Menglong Dong <menglong8.dong@gmail.com>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kernel-patches-bot@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2026 at 11:09=E2=80=AFAM Ihor Solodrai <ihor.solodrai@linux=
.dev> wrote:
>
> On 1/28/26 10:49 AM, Alexei Starovoitov wrote:
> > On Wed, Jan 28, 2026 at 9:34=E2=80=AFAM Ihor Solodrai <ihor.solodrai@li=
nux.dev> wrote:
> >>
> >> On 1/28/26 7:35 AM, Chris Mason wrote:
> >>>
> >>>
> >>> On 1/28/26 10:26 AM, bot+bpf-ci@kernel.org wrote:
> >>>>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_com=
p.c
> >>>>> index 5a075e06cf..070ba80e39 100644
> >>>>> --- a/arch/x86/net/bpf_jit_comp.c
> >>>>> +++ b/arch/x86/net/bpf_jit_comp.c
> >>>>> @@ -4112,3 +4112,8 @@ bool bpf_jit_supports_timed_may_goto(void)
> >>>>>  {
> >>>>>     return true;
> >>>>>  }
> >>>>> +
> >>>>> +bool bpf_jit_supports_fsession(void)
> >>>>        ^^^^^^^^^^^^^^^^^^^^^^^^^^
> >>>> This is the actual function name in the code.
> >>>
> >>> Ihor, I think the script parsing review-inline.txt chopped off the
> >>> part of the review where AI was complaining about the commit message?
> >>
> >> This is the email body pre-processing in KPD, yes.
> >>
> >> At some point we decided to remove the commit message before sending
> >> an email, but now that AI reviews the messages too, I think we should
> >> just send the generated review-inline.txt as is.
> >>
> >> Alexei, wdyt?
> >
> > I think KPD is only supposed to trim the header until 'diff ..' line.
> > In this case there is no 'diff', so I'm not sure why it trimmed so much=
.
>
> There is. Here is the PR comment with the review:
> https://github.com/kernel-patches/bpf/pull/10868#issuecomment-3811930805
>
> KPD trimmed everything before the first "> diff" occurrence, as expected.
>
> I'll try to fix this up in KPD. We should probably search for the first
> line starting with "> " (a quote start) to trim the header correctly.
>
> Alternatively, AI can be prompted to avoid generating the header in
> review-inline.txt, but that's probably less reliable. And maybe it is
> useful for local runs, idk.

I see. let's then strip the first 4 lines ?
(commit, author, subj) ?

tbh this one was unusual. If it repeats then yeah '> diff' is a wrong marke=
r.
