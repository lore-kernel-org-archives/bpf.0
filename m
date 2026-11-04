Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793758873;
	b=qccbrbJtvh7jckFiHE08+ovbuwoQEONsw29pAFWyz5GVMX2yNFIVuhVRuuL0luRCUonv
	 E5wfVNIN2+D8xUF1MKbkm+Tt9cmQHb/5tgLDibveGnXD9gcwFz6iCn+enwgnVW12rL2+F
	 N3E2F2MwliZAD7gac8Wb/Zyau+1Nvq86p0azDtrdKHuhnrwLHZvmE4HUR7EH0dDsRSFQv
	 3jpQ89TcDuiqTNMia9CeuYWXIRCP4OPX68MZDO2GEmhOasQIVYMhJZjCFeOdLSGqBWtlv
	 l2t0bS5MT9G9DZB8ClhcQZJvKYy+BeF8X7//fh9Fr+PSukcxOAdWyDYLhXdFCM8HVYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793758873;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 To:Cc:Subject:From:X-Mailer:References:In-Reply-To;
	bh=3kL9nPKcOeNL1nqkLRFVJC2yAbsuis72ch1sU7/sTFE=;
	b=BWAqXikx+gCBKrdaxLvmy2FjPdLbzEovAWKL6nnaZOO5YXzMfwOI8pBZVJkoW6o1esGq
	 C7mijNJ24hdSD+/V1lDt8e5QfT8ieaO78iV9SdKrjclESa4j32X7Mzeaz+pSeH8F/HbkK
	 x8NuFWeJe3JR5axi+d0LYa84WtreUMp3tj5ifIh9wKyWGMvfJgpOWsn0w+uTfMv243xh1
	 plErD5RyqinUD4t2jJqWQwJq6bRRh8OuNk4bn9PqEAOnDtaJ+lo6WI0t1qgxSRCizXu0w
	 Jj1dXYIU2qj95IhSYNGlJeCoYzTyRSRMfTyGB7ZwM9vfCm1CUArPdKmFRo34LNU6Jdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ufKTEGLW;
	arc=none smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED98606A32C
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 02:21:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5ED98606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ufKTEGLW
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8a4c72951b8so176996b3a.3
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 18:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793758873; x=1794363673; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3kL9nPKcOeNL1nqkLRFVJC2yAbsuis72ch1sU7/sTFE=;
        b=ufKTEGLWP6UzLiCvOprUKER8FGsbqdunjCzIauuX5gywzqqPVl+M04XmyTRhrXyYRY
         OLHdnvsB2Q3L2/l4WIvSgLWPqGq3jbQBp8VKXEuSKCkxD0svr0yCR4LmWr7yryrJc2bB
         YeBWHIeqqmDfWaK1aYk2NE/L/4cR3rj5zLhms+3FPKYh3/Ja/uvm0m3HxJeF28j0WRDj
         DGp9zVTDFdSq2pixbJ67BHxlrsa3M6as7tc/hgtMq2JeTR3ApTTvZjRj3zCN8OhiobmG
         4Yev4utAiH/WQ44huAkHJDNInnMcXRlSSj98SGnMtvV+DWBAYiyFj1/qP2Mu+J97hzkx
         Jdmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793758873; x=1794363673;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3kL9nPKcOeNL1nqkLRFVJC2yAbsuis72ch1sU7/sTFE=;
        b=tOGv5JBD4afrS+CMZcJkF+AS4/dL0D/4lxXTe5amsdEtxyUEtTx6VRK2yDwpZKJg4Z
         ROuok2jtpOpPalkI52SqblA5lnRXDmWe5c59skk8h9Ff3SWpO86b+ABe9wfxHQsNq+4b
         29Ys89q/TybETikj6mAUF9eWQaZAvmAxJCt03Vvp/a0+z661Q741FICXsg5n8KZ8hPLu
         TdE8HSikw7ZkiV5DpWPE6I2/x+DCiQNllqSEybHp1Y8Mhxk8MMK6fFbWyQzH3i39fEiY
         /er0KEmwtFBatZgkK/Y6TilKpVtIoC4iCNTuwOfF1IfiWqdWQ9krpASADjyTLmEYzN1n
         w/MQ==
X-Forwarded-Encrypted: i=1; AKwUvBw2mS+rV4iQ72MUdz9OaQ7c+2QPnUMIcWzJSNg6kyT9NcXab/ZLMatBuvHFpHdftzP94Ks=@vger.kernel.org
X-Gm-Message-State: APuU4Z+zY304oQwQko4wDCkkJ5KHEvyN5/3P30O+NaQ28TC2uriGndy2
	kEasyH1ir5u7JOW6sxO0+LP0XExWap2qqOC1Ff63jWsfyfQWCDkBk3hQ
X-Gm-Gg: AYBFou0Q/1G1FdqTr1NubFi+LPWLqzD95TRkLBz1cR8v5O5FTuhvX/xhg/myIWFf4AH
	m7jOl1Dw/brfUOs8GMXRNGUrglHcSmrdXrlF8Q2js/S5iZQ11EacJ6AlRWH6LI24fQRH/xAlwMg
	11FAL8wTo78TDQN55Ut9Os0p6AqcwFjPCRRWVxnkXcTtwxXO4Ji7QUnknRGwWp3tvW/6Qfvh1bB
	Llx7rcrcGsSrIMXvU0b+ZWqt5U/8ER2u1pH00Gmw7RuN6BodOwFOTZF2d+wzRh70DCuds6EMAqZ
	rCqitnKxYrRP8EePJhgfn5Yv8BGYTjq23eiLDhM4VAdTE2Ocn2g9KfhpWirgnK/J8ZfT+0VmVM/
	8YjLbKXbufivMHJbGUZTJrMIMmr5pSOwN0tR2mhULOGNCCc+dvucFCWX+c2BHl/rPn88wBA1uOx
	P+3D3Ndxn50yXlcQpotJ9VETa/ZMBrCtw97XnPGYNbBWJvCj/zCDse9dAQHbOv6ff2a2PPWEVEG
	DUcK9eP8Zb9tdJgJL5lrrdKjv3FAOz87UEs6ErURcXMN9MBP55YkJnnIJ3qFVB0iaplN3IEypYR
	yzzonmz3fLMsZUb3JcGulHCTU5pXujaW/WIsUC708eakHEwY7rxE36zAkHhO/sptusAvVM81Bw8
	dFjobofy0z2toBplEQGxgCB+P5mCVsSmWVgc=
X-Received: by 2002:a05:6a00:230b:b0:89f:6989:cb9b with SMTP id d2e1a72fcca58-8a9beb6284emr11317502b3a.27.1793758872638;
        Tue, 03 Nov 2026 18:21:12 -0800 (PST)
Received: from localhost ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b09b470b7esm233999b3a.32.2026.11.03.18.21.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 18:21:12 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Nov 2026 02:21:11 +0000
Message-Id: <DMM2G9OX9ACV.231CHJEPK0OHU@gmail.com>
To: "JP Kobryn" <jp.kobryn@linux.dev>, <mikeba@sentinelone.com>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>
Cc: "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Song
 Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri
 Olsa" <jolsa@kernel.org>, "John Fastabend" <john.fastabend@gmail.com>,
 "Shuah Khan" <shuah@kernel.org>, <bpf@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC bpf-next 0/2] bpf: Do not let preemption cause false
 recursion drops in trampoline progs
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
X-Mailer: aerc 0.20.1-355-gf870624f6c37
References: <20261025-b4-bpf-trampoline-preempt-v1-0-198dcdc0c6ac@sentinelone.com> <DMIIV9CE0PN4.309YUGIXQUZNF@gmail.com> <e3f63654-0f7c-462b-b58d-05f3164fe340@linux.dev>
In-Reply-To: <e3f63654-0f7c-462b-b58d-05f3164fe340@linux.dev>

On Tue Nov 3, 2026 at 11:46 PM UTC, JP Kobryn wrote:
> On 10/30/26 3:22 PM, Alexei Starovoitov wrote:
>> On Sun, Oct 25, 2026 at 04:02 AM Mike Bazov via B4 Relay <devnull+mikeba=
.sentinelone.com@kernel.org> wrote:
>>=20
>>> Is disabling preemption in __bpf_prog_enter_recur() on !PREEMPT_RT the
>>> preferred fix for fentry/fexit, or would you prefer a different
>>> mechanism for reconciling preemptible execution with prog->active and
>>> the per-CPU private stack?
>>=20
>> No.
>> We cannot disable preemption, since progs are not short
>> with may_goto they can take 1/4 sec.
>
>
> Seeing this issue as well. This patch opts in ALL non-sleepable programs
> with trampolines. Alexei, would your thoughts be the same if there was
> an opt-in approach, like a libbpf annotation "fentry.nonpreempt", for
> select programs? A patch like this could then check if
> program->nonpreempt is set.

I don't think it's a good idea. Try bpf_preemt_disable(), as I mentioned
in the other reply.
