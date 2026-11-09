Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794227623;
	b=qZp6SCuM2Udx+pWojC0RcoSqtbWxvoTfIXpIaz9TwPZ2PxuY8ZbD5DMQ+/ik/ShMv31s
	 0sFXEhvNNRZ2VzKT1TqKs5P0p9SqovZGHW5x4Y6lg0tHfSnbwjiFOoX7bkI4IAAhPOBOu
	 40guf9g/TD4T9rjLnBloV2cKbTXV/AeZdzJz7Y0brVJm1HBCIUesEkPqlBoI9JYpwV+uR
	 owjOyxN97o9t+Auyr47ZrfrIwuP3CNLHl5qHQjtnLN8uam2b63FbGVzh0ZK7dEvK4soTX
	 98xQl98FFX1b/XZH8s2B/85xHN4m37XjlIkvQJAacqKtlcPjr9MUxCzKHh3OmGU8c2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794227623;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=2JV1b4sF9Bv6mNizFqSbv38ZX8zLnn64bzrFb3DOKnc=;
	b=FOoDn3Wou5D2T7jVLyYWdGgf6wXQHZsyQrmG8QAn4NWDx0Pa/9y8bHAegvnaBjEz6fCu
	 AW4mlDLuHVYYmv/8isBBap/NivQU0HezTYkQhVrSVCcKlV0B1R8/Teoh5eBb7jKH/vJ1F
	 zLV5c1tPNQVPCFDaq461+gezZu0BGVL2gDP+//sWBvYy0pfeyqNkhen21OLE3UuwyIUGd
	 A2mR1VQ9J5NhPwwfsS1utGVUo+L1U2nMiG1KISwlZRyirUpt1HESXQUBaUgP6t4AKZ7sB
	 a6MdTSDeZ70KJ/WD2AbfLCqSXAi+b6mOICeGliLPQc6kGNDlpybmE2lodIdIlgR0z0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=debian.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=74.125.224.41
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44168606A323
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 12:33:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44168606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-67bec5dc8d4so418180d50.0
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 04:33:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794227622; x=1794832422;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2JV1b4sF9Bv6mNizFqSbv38ZX8zLnn64bzrFb3DOKnc=;
        b=TlI2bc2YQUeg1ga9CPBmOhhsUmScLtJGwD711m84RWBJi3Z3KDwQKtZA7lYPXhNUAj
         +BHsDa6bZm0ctSN92j1JR1sjt0tQyxrHusupKy+3UDy4+5gA7uzUvJqx2yMU2cCId2X7
         zf3vT0V4gyt7h5uuSxOjvyHxLf8X8p+FUzF/Jn18YEytNJK8VQsRPiS/f5A6OW3Z7zYp
         5tHnXoJSreKd++2M0bikl8QOBDcuBz8cVgpFPtRIowReropp+xY5AwyGDdvrHOLs4LUU
         Dg2MAuuwoi5BE4qERQX7xxmgQhZjIeRQmWoke/eIgtJNc/S/F7TRp8F3YUxTWKObcPao
         Gsdw==
X-Forwarded-Encrypted: i=1; AL+hErEifIvRlVtndxdVMPn8ODUw+K0aiS+v1on9kPRDS9pCmwL/CIDq8mjXLgyx6DU1iaDnCRs=@vger.kernel.org
X-Gm-Message-State: APuU4Z9/YN/X4zR2Xu3k6dhA6ZK/nS3aml7rKraFYdnPz2bGjeibpBW0
	asJ0886NwOwbqmaKPAP1/lWafsrN9FebtbWJIdreDFXeAiXhl4om+2WlVdYhOA==
X-Gm-Gg: AYBFou0VO+YRP/STmMXMDfnw87K5W5B2i7mnd9LOoArxXBrGtSTOev9BFm6X2zmBGyJ
	y2bSfusA5o44obETryjMB7IpwqCgdRxgJlJ4RzYlpH/5fiiOvVz9dK9gWMyygJ91iHlghD+Ims+
	d93avK6IyacOev7RrcQd6Xumbmfi0uayQwK8mz79QjN1XTpPFICmxZUMk6bsYvtkTRtehQUceY8
	cLZYHfhB46nixIll4clTo/iOs4DlbyhqJ/ZY/ed6WAhbcCFQQ1riy8J0gl5BcTUqYbza5N4l0UC
	YYNUKBY5vBtX0RNOnO5Gd3AGJXALsYCjgvHA3yORp3t0nRfaRUD6uWooq5A8Bv4fi1BzYJmrsbq
	GnQmRxdktzv0iuaWIw4ekhZ1wF7LdZIoikt7nbNAbGEljeddqneJiAJZEPXdSq2vXFcworrpSg0
	OXh1nH2RyaXhP3IGdO3bmmnX+fPdEbU89t+Jz2MYsx+5n6gV86POXrqIVpHjoDqmDVbFIRUiZzu
	r35oewICHn6uOjVHllWcyC/rp8t763XJwEzzQRzRuWAWpWYaGbMnlxP3h3BvXjdtMQ3zbW+gbHJ
	X7zBLujJo90ccuyoGwE=
X-Received: by 2002:a05:690e:1442:b0:67c:175c:df66 with SMTP id 956f58d0204a3-67c3d963260mr2729393d50.36.1794227622290;
        Mon, 09 Nov 2026 04:33:42 -0800 (PST)
Received: from gmail.com ([2a03:2880:24ff:49::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67c3b93be27sm3766906d50.11.2026.11.09.04.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 04:33:41 -0800 (PST)
Date: Mon, 9 Nov 2026 04:33:40 -0800
From: Breno Leitao <leitao@debian.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, acme@kernel.org, 
	netdev@vger.kernel.org, llvm@lists.linux.dev, ast@kernel.org, yonghong.song@linux.dev, 
	bpf@vger.kernel.org, kuba@kernel.org, tj@kernel.org
Subject: Re: [BUG] bpf: tcp: bpf_tcp_ops_set_rcvlowat() missing from BTF with
 clang KCSAN
Message-ID: <avG9bk0kxRUvonhD@gmail.com>
References: <au27Y9m78_3EH2v1@gmail.com>
 <a69dd097-7e71-41f0-9a6b-eda001773236@linux.dev>
 <au347UiVUe5oUuxM@gmail.com>
 <au4kpSGVSH3tYiZm@google.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <au4kpSGVSH3tYiZm@google.com>

On Fri, Nov 06, 2026 at 07:05:25PM +0000, Kuniyuki Iwashima wrote:
> On Fri, 06 Nov 2026 07:58:01 -0800, Breno Leitao wrote:
> > On Fri, Nov 06, 2026 at 09:16:24PM +0800, Jiayuan Chen wrote:
> > > Thanks for the report !
> > > 
> > > 
> > > On 11/6/26 7:38 PM, Breno Leitao wrote:
> > > > My arm64 KCSAN builds of linux-next fail since next-20261015, because
> > > > bpf_tcp_ops_set_rcvlowat() is missing from the vmlinux BTF:
> > > >
> > > >   WARN: resolve_btfids: no BTF func for kfunc bpf_tcp_ops_set_rcvlowat in bpf_tcp_ops_set_rcvlowat_kfunc_set
> > > >   WARN: resolve_btfids: unresolved symbol bpf_tcp_ops_set_rcvlowat
> > > >   Failed to generate BTF for vmlinux
> > > >   Try to disable CONFIG_DEBUG_INFO_BTF
> > > >   make[4]: *** [scripts/Makefile.vmlinux:72: vmlinux.unstripped] Error 1
> > > 
> > > 
> > > 
> > > Has pahole fixed this issue?
> > 
> > I don't think so, see the line below:
> 
> Could you try this ?

Thanks, it fixes my build. I tested it on top of pahole master (9eb594d)
with next-20261105 and clang 22.1.3:

 - arm64 KCSAN, CONFIG_WERROR=y: vmlinux links again,
   bpf_tcp_ops_set_rcvlowat() is back in BTF, __bpf_tcp_ops_init()
   returns 0, and progs/tcp_autolowat.c from the selftests loads.

 - It also brings back scx_bpf_tid_to_task() that was work arounded by
   tejun.

Feel free to add my "Tested-by: Breno Leitao <leitao@debian.org>" tag.

--breno
