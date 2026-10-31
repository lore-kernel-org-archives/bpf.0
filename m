Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793466609;
	b=HwFm/kGocLSOVj5vlt049sVaZW74DA6y8ixYlPDqhroxpA337Ia2AaiU/9xSEyJzh/L8
	 3BtYl5IY+HNR1Flxmpw5H4zmBZlaDq+hr1Ve7Dvij46s9Y8D/Xo9FGzXAXxpgifmixWvv
	 Zrm2TlwsIIo6HuzMhioF0xnHz0R3CpB78UIgJb9siDf9P5V9yXZAQs4n/EPvBGkI4PWBf
	 MnppSd/0CvnhtFRbL5qaSVvLveTPAqhPoMD5qtI2d8RTMJH4hj3SroueatvD+jlmPyIw7
	 L1hfnJrowRwfm9JrDVe9ZGw7QsWBnUuudGHs9F+ujeuXpezFICxFofUdFFIJdNX2Geg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793466609;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=S02zFKQTw98qLAlbNryreV97fiHHWFWx7ndQG3y57t8=;
	b=HTcVzOo9PTdoQ2vC9ykozeGPWkpRV7mVY9AlPip14eOiYHNjKYlIYynE+s8J8z0/5btL
	 lOIsH0jAtG1py0/yE0fT6wMHhUz9QMjGuvecg2ccAS/6zylCEmU5yUrTg9LzD2xQJzhZI
	 5FgSE3ok6Cz/oeublHN2ubvySGeyJkpG9NzNP4Ed8r2dE8YGe/IOUZ165k5RtLi6GVKXg
	 kk4yTErr9ZJVmONhn7i5WtWmdiWTM4CxdBxwRcVRJ1tNK3ga7fhDlBlADSQbChmdPh1UJ
	 ysgBN/UTypQ4vS9enRbCtCGv6dXgnsPlmPurk3JlQUEebYWEhe1H0GTnsjLzvzWCBnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zAlQpn7V;
	arc=none smtp.remote-ip=209.85.215.173
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512A6606A321
	for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 17:10:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 512A6606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zAlQpn7V
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cd5c9e52398so817757a12.1
        for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 10:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793466609; x=1794071409; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S02zFKQTw98qLAlbNryreV97fiHHWFWx7ndQG3y57t8=;
        b=zAlQpn7V5Yxzz3a/EooOjbQS76Q6xQ0YpJEIcGp4YzdScOrPhhAvrUur4/FQHYJqRA
         8zfHghpz6jXKETFWCpI+22lxZ4tiU8Y1Wc2I1LGCzNcA48QIfHM0NthCxotitdxVloRD
         7jW5L//FxVzW4EuToHyaxOBM6p67ZQEXBbXMiVGM13bEtgPc/LRBcWVgFZo7OtjjXbae
         x38X4P6bQH9CmqpDSl/U0Gq7hPzrHgec0DsPUl+NFmdA/2pRimxjub456nrjYLulRtoc
         kY3kMmeFOtp3fe5XwkcAgy2f09rE2oqb/7WSkbZ5wd7smSeRqi0JaRIl0JBf3GPVA6ml
         lPLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793466609; x=1794071409;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S02zFKQTw98qLAlbNryreV97fiHHWFWx7ndQG3y57t8=;
        b=Z6ordswOqTBC7/xkSbSK0cR+2ocm3k9mZ35ftbZZcuwBwF9iXIa/ubvoUx8J4MWLrk
         JBFyqRc9Qc2vfrLrfI6a+czKZK8qUKHdFSdl80NGPiD5nM7rQwi2UoCP/s+bdtGtGlxT
         pAF5s6C/UA10u5G2mOLi90beAkgSlPEsD0HTZMqhTBpKqrs/S+k1pQd/hNGO+2PlTgRa
         +K+iXwQUvZ6TU7KZnmKvJSRqxaDt87WhvUhKOKL3FYqI4o91vm7Y+Ixg6ZNC9KtTmSQ0
         Vd/gDHNqVZ5S9zZi2VPR1elDQClRJ7+5VuGDp9easXeHMB5HaWWr7/f3oN/FdPHCuS+l
         YKPw==
X-Forwarded-Encrypted: i=1; AKwUvBzN/vO4IawinutK/gHs6BfZE7jW2osr6bdPix7dFffQn2k85JEvoExZJ2ksfYcdtQMLE9Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYJKK8+a64rkzYryqDKXswCWzbHldmm9nU7NPgmEDpW5BaWSuE3p
	SnCRnx9QY+FJ4/sfMDVU+b8/ZclwMhHlnGmmONhJBdgflcQjJckzJGHq
X-Gm-Gg: AYBFou3HceP021I4k9gtX0YuGWEwfmxPG8/QjvmWubPlHGPpu0ljWVLR8gZX+vzSpe/
	PMX5a5/EdLmSo/D6fm6tq/f+3d2ZCkPv8BvEP4S+LewiLyv9EelHCTYSSatS9U1p1A3Q4H8XBt5
	8RQY9USUrLf8Vk6Tpqiq5IpoGGb53om7tIaJA94FCJ95zVzdMK8dkzh6TI3wtz6935MRuYusB4R
	wseSywFlLkPSlp+Kxc49mOvgny270vv/ZJiC+wXxVbz4KDGIK6ceY9QJ0CZMZ8WZt2Kok3N2Qdz
	MtDH3Ty6u+OC/6J5iqp5+BKu9Ual1TwFEHtMXpfIC0nT0ZUppuJjFJ13sHpHo93aOVrtSHH/JsY
	cvcd3VI3YdQlUwt+PGv9WW3BQXZIInR9zwBbJYHztz7n1IgszBMXeRgksr/Qg2PkIT/rQAJ48ES
	cTOtpcsxH50ao0UwJh6OPPJp4nCOW06qw2CqiE7RMxONC50fM1ggmPO8SNL9UOYF1/+TFPxrtOj
	1ySdDoLBcIqNYXYTcjMGXPIs88BChmljP54PJGw5XoI7zS9FCA5UtjHFiw5q3Sv8OLxsxbyS6Rx
	XoEAe9LYV1Q9poM+k+ho6qytqP0/NIdCa7boSjqoQ61iIE8/w/czF01KEdsMSfZFJx7EsFph6FY
	Y9nH6p1+748YwgFmPiJenPNeTPSBeKzvb4g==
X-Received: by 2002:a17:90b:1a8b:b0:3ac:9e76:aa76 with SMTP id 98e67ed59e1d1-3ae8970fd9dmr5106038a91.13.1793466608564;
        Sat, 31 Oct 2026 10:10:08 -0700 (PDT)
Received: from localhost ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845df666sm8093713a91.14.2026.10.31.10.10.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Oct 2026 10:10:08 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 31 Oct 2026 17:10:07 +0000
Message-Id: <DMJ6UP7FV1X1.2E7I2ILPBS34P@gmail.com>
Cc: <ihor.solodrai@linux.dev>, <almagui@kernel.org>, <martin.lau@linux.dev>,
 <yonghong.song@linux.dev>, <jolsa@kernel.org>, <rostedt@goodmis.org>,
 <mhiramat@kernel.org>, <mathieu.desnoyers@efficios.com>,
 <linux-trace-kernel@vger.kernel.org>, <nathan@kernel.org>,
 <nsc@kernel.org>, <linux-kbuild@vger.kernel.org>, <arnd@arndb.de>,
 <linux-arch@vger.kernel.org>, <x86@kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <abuehaze@amazon.com>, <doebel@amazon.de>, <mpohlack@amazon.de>,
 <jay.wang.upstream@gmail.com>, <martin.lau@kernel.org>, <mason@kernel.org>
Subject: Re: [PATCH bpf-next 11/13] bpf: keep module BTF until the vmlinux
 BTF is parsed
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <bot+bpf-ci@kernel.org>, <wanjay@amazon.com>, <bpf@vger.kernel.org>,
 <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>
In-Reply-To: <df56aa51cd704ab9a9b03d3574e6ab4c61d5e6d4cdddc17f4b0253f67cc077da@mail.kernel.org>
References: <20261031130959.23472-12-wanjay@amazon.com> <df56aa51cd704ab9a9b03d3574e6ab4c61d5e6d4cdddc17f4b0253f67cc077da@mail.kernel.org>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Sat, Oct 31, 2026 at 06:55 AM bot+bpf-ci@kernel.org <bot+bpf-ci@kernel.org> wrote:
>> +/* Undo btf_parse_kept_modules() of a round that is not published */
>> +static void btf_unparse_kept_modules(void)
>> +{
> [ ... ]
>> +		btf_mod->btf->data = NULL;	/* the kept copy */
>> +		btf_put(btf_mod->btf);
>> +		btf_mod->btf = NULL;
>> +	}
>> +}
[...]
> Can a module BTF that is rolled back by btf_unparse_kept_modules() still be
> reachable through btf_idr?

Yes. It's real. The NULL deref in the inline BTF is real too.

This is quite heavy. As you can see both bots poked plenty of holes.
Five of them are in the -ENOMEM rollback of patches 10 and 11:

  where                        what goes wrong
  ---------------------------  -------------------------------------------
  btf_get_fd_by_id()           takes a ref on a BTF that is rolled back
  btf_free_rcu()               reads btf_mod->data that rmmod freed
  btf_parse_kept_modules()     -ENOMEM in the inline BTF removes its file
  bpf_struct_ops_desc_init()   -ENOMEM of ->init() becomes -EINVAL
  btf_vmlinux_data()           -ENOMEM without btf_zst repeats forever

The rollback exists because vmalloc() gives up when the task is killed.

can we run the parse from a work item, schedule_work() + flush_work() ?
A kworker gets no signals, so -ENOMEM can be final, like without the
option. Every parse then ends in smp_store_release(&btf_vmlinux), and
btf_get_fd_by_id() sleeps on btf_vmlinux_lock until that.
Then no need for the retry, btf_unparse_kept_modules(), the 2nd call
of ->init(), etc.

See my other reply.

pw-bot: cr
