Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795051030;
	b=ztzN5CqvtEdtDXfdUoHzWpmI2aCZZ6ySOApPFiJfAOpRWvps6o0OtT06RjJ5M6dFgJdb
	 qCL3KNH4uV6Ur13D92Rm0sMNTThjRT9Reeed52T9WO4eO7vmZstGCR98K3hyqt7aqt/zZ
	 9DEcVyqKK5CV43HZfRSmr/OWNUW1e39KdtIYBuYjinaije2NLyg4tOAFwlMrsqqIBU5Ws
	 Fm4XLEuiReHm7fP6ZikqQnvH2AxMQ0V++S/sAmGrijWmgL3aFYGakO1vGZA2taHzmpdn/
	 /oinFz4OAQcVrv0qhO3T4lNhYeqVro6QLTmT5hs8URNYjKAJieuMlbXxa1onqB4m4uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795051030;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=59Vn+6ZCrn4bkmigHbGhLn/ZQOyW7NScFiy8pChk97U=;
	b=BErGF426/j8WnWcr5BzKD5ttxohyUyueJvV5TPt53kCDtS7iExd39RCwB22OpH6RnEh8
	 3hkRXp1qL5Y0A6V2rYYzlQB/lZdz29o3ZWEK+GEBin040GWK7v2a/P4wccO3qX6KMtj/4
	 umo+IVUTcxno49aUVq3zQpKkSzJNRawSoaQ9lIK996pefRlWKUe7uw9v+Seawt+sLTWPN
	 OTvEjg8KQehXcSE58331rNfeU5yH/zY5jPEpTYARHmap4R/l75RClfSSWkQmEeVqsOe1D
	 D4FeOKnSFOTXtWXZJGwbAEf7fukbdE8fB+YhWj3f4ImfSS8TBaRGzkdGTUZV7dd9+GA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OodLDqWV;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068D1606A31C
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 01:17:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 068D1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OodLDqWV
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3b08a162d4bso975281a91.3
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 17:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795051029; x=1795655829; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=59Vn+6ZCrn4bkmigHbGhLn/ZQOyW7NScFiy8pChk97U=;
        b=OodLDqWVLKJWRJ4hxsJ+0H/bezzEwzFKojs+r32NAdCAkVMc4Nwq1iDewob/8kYBUv
         JCfPxpSQ0HMUags40Mt1pFZ1Gkt1tkJ8RqaEVbemFmkZJsRHtcjynKb6UZI+MEUaKplg
         i+aQ5CLAjSvcZpVSNhZFAnuVWMV14aj4vhpSEkUdnpnygjvdVw2IvjbA0YRQMV6jrS1o
         clGsv6cndA8hxyP+N2tDp/PL9oxGHjp5BWXzOtscSWyHARXkcSK9Z526nre/f3kQDQ3l
         e7nAdv672XkwpthS6aIWB1g0G9K42GfA23U+7MqGA9SAp1oRKVgq+Usm3JkEr91+e0GQ
         6v6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795051029; x=1795655829;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=59Vn+6ZCrn4bkmigHbGhLn/ZQOyW7NScFiy8pChk97U=;
        b=yU6MfV6moCFRVJzF5peXtPay2ESywE722sFmCEVlzuVNd6LbyFdUq/esKSOPPAVYQ3
         NRUrfAp/lSlyAyIT7aeDKyYI6R78DDzzPl03xWKt4dkOBdVjuLXf9Lc75W+DKsKjzsaU
         BMYIJFrNo9QVmDGgTgd5KOcoEwZwOGbFKRpRnSBn0RriXoEkOJaR2EsmXAiyasuTNa+X
         9F3YURoChzfpF1cz05/PDOSQMCiPCXfdAQZC+01ntb+IMvw/FpdGHENxwyUYdlct64SC
         JyXQQBSUtq2qCIllOkRKYFh+orlFcO/b+wz+Ch8vVbXiFMlLIv6woP9s3FE9d6zNs5On
         8UDQ==
X-Forwarded-Encrypted: i=1; AL+hErH56UBSw7M2kwBMZxM1jM40KRC2bijGPNJmbyei7uTMgTml46hGEQHcriqgqxEOblf8T6k=@vger.kernel.org
X-Gm-Message-State: APuU4Z+CZ9XMvxx1x8dFkfG7F9tzKWixVDmhD7QsvJRuB1NlnIID8aor
	qRpbgfKKNB9F9gYgkKCeerg/KHV2J7MUXdlH1cGlYIkpJNNkJePjNhTD
X-Gm-Gg: AZFdTZemhq8o5KxzYcoRVKztOei6alvIeIDdpumNKV0BeK88xUmc6Fg1+zE2Yuop9FW
	wyTrF4OJ3Ggkzj8JEiDXRmALPfJcHz9ghMEwS3KlCAvc7AHVpaEGwz/5q/dgscSL5B/SQpa0npv
	UoBt8ELviSFAH+5VQ02taqLzyjTSQP45rWrt2jq12CBAT9hgeDhGt7WQfKf3bZRNYxwnQKgT3/F
	Z7dXyqKtWGJntejkAkKnplTleHU0p/sQOLZq9VhVNhwF95n5jJZkhzWMHAE89H4vcRKgqr8R4h5
	bfkyQS6Cjo44AXrZZVU7TmvS263QG8c1x6W7SxhNqIkmuKZfzTj7xlAIMfhjLA956xArV8wWNbD
	HkbFAHmaMM3JUgHA6lYWjygnS9/c9CpvIHnp6EtXOx32zzInpsIebTgvedHiXTz1b8UZbZldgZh
	vt4dkI0YEKQTp/IDU05tkuosud5zTAq+oVl95SeMcesANJnVVeo9Xcob8Wza46RkVsfD5sWJlf4
	2kwez4hpWxfVjoll4wApkVWNFc1HdLfBBKp7FsMxtQrl+slpPve/ws+CnO3yySQOQm8xv8gP2f6
	vpFJ2gveuO3/v/fO/VJPIDxF7J89rJCL+OYq3xd5gVWncMBTaKTidTOiapeO51mweZFpBN/tkGs
	vZW1crFRbMrBOSE9dafa0HFhGOONUNN0bHA==
X-Received: by 2002:a17:90b:3e82:b0:3b1:2810:dfdb with SMTP id 98e67ed59e1d1-3b3d07a85c3mr4591922a91.48.1795051028783;
        Wed, 18 Nov 2026 17:17:08 -0800 (PST)
Received: from localhost ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b402981814sm107875a91.2.2026.11.18.17.17.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 17:17:08 -0800 (PST)
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
Date: Thu, 19 Nov 2026 01:17:07 +0000
Message-Id: <DMYSHE1LVD7S.3IT6CHA55HJGY@gmail.com>
Cc: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Daniel Borkmann" <daniel@iogearbox.net>, "Alexei
 Starovoitov" <ast@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>, "bpf"
 <bpf@vger.kernel.org>, "Networking" <netdev@vger.kernel.org>, "Linux Kernel
 Mailing List" <linux-kernel@vger.kernel.org>, "Linux Next Mailing List"
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the bpf-next tree with the bpf tree
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "J4f J4f" <shlomojune6@gmail.com>, "Mark Brown" <broonie@kernel.org>
X-Mailer: aerc 0.20.1-355-gf870624f6c37
References: <avzIz70qnJIA2t3x@sirena.org.uk>
 <CAE_LbwkvPV2-LJ2b7OCFzmWmBP-jfxeMR=ARZJvuF4RNx8M1dw@mail.gmail.com>
In-Reply-To: <CAE_LbwkvPV2-LJ2b7OCFzmWmBP-jfxeMR=ARZJvuF4RNx8M1dw@mail.gmail.com>

On Wed Nov 18, 2026 at 3:47 PM UTC, J4f J4f wrote:
> On Wed, 18 Nov 2026 at 05:36, Mark Brown <broonie@kernel.org> wrote:
>>
>> Hi all,
>>
>> Today's linux-next merge of the bpf-next tree got a conflict in:
>>
>>   kernel/bpf/btf.c
>>
>> between commit:
>>
>>   b7cc45994c3f9 ("bpf: Check variable-offset accesses against special fi=
elds")
>>
>> from the bpf tree and commit:
>>
>>   ca4395aade31a ("bpf: Walk each type once when looking for special fiel=
ds")
>>
>> from the bpf-next tree.  I'm not confident of this merge, it discards
>> the bpf commit on the basis that it looks like there is some new
>> handling of special fields in the bpf-next tree but I'm not sure that
>> overlaps with the fix.
>>
>> I fixed it up (see below) and can carry the fix as necessary. This
>> is now fixed as far as linux-next is concerned, but any non trivial
>> conflicts should be mentioned to your upstream maintainer when your tree
>> is submitted for merging.  You may also want to consider cooperating
>> with the maintainer of the conflicting tree to minimise any particularly
>> complex conflicts.
>>
> Hi Mark,
>
> Thanks for the report.
>
> I reproduced this on bpf-next master: the rewrite does not cover the fix,
> the check in btf_struct_access() now only looks at min_off again. I will
> send a v4 rebased on top of the bpf-next series shortly.

Pls ask your bot to stop doing stupid things.

