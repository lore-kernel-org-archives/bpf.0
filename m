Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9C6472082
	for <bpf@vger.kernel.org>; Tue,  1 Sep 2026 08:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788250145; cv=none; b=iGmP5m+ed8967XOl45WQlogKO/gfIcFvv0cpnyYqm/we0aSaeoWVFwrnCesoNzlCQ8J5VPpSd46a2RxYb7gHSdDHk/Pnj2/bXyGncKGcsIEqBHCo0/FHT8MN0opi1R/zS/aaZMRG8C7Xt7Xnw0ukVDGf3Zg8lqBxR/PXm/9usiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788250145; c=relaxed/simple;
	bh=e24LupsMA64t+dWKS/tFJ47bkn/CtfBkx6KSXCb9d3o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lMbMQYDmLgrDkgSJ/Kq3l9wBrbQYNL10kK3WLgsboCr0TAdsu0GsPpdKS3yZYRBXNE/GcSohXZO9pUqj5HMeABNsCkH7GNLUt8S5X/DPN+OwGCaxEERRdaO9EJ1iX7uKtOqNw2qogqNKgcZckU0JOnCZNXdHqJdwsKk50P17ZnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K4Hk+SM3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UndXa1Kw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K4Hk+SM3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UndXa1Kw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788250142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XdL8zzc8V9JkK2rUeyT0WO94d4yIRGolbKfwcYc2drU=;
	b=K4Hk+SM3T79ARiWO0VlI5JzpgFJBNf2aUrIzZ8jqguLBXIvje4HOc6Ys74cqHOFcUL7mPR
	kOtrPOqsyZymMdDEmRRo19d2x+ofc6240yMk4cfH986tl7m1yUmHHu9igNPa6PeRO6HUtZ
	ShePO5rB2QWoqjq0ZcZKoU2YVdjDK5A=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-JHK-_1T_NSSFKoP8KO8tFQ-1; Tue, 01 Sept 2026 04:09:01 -0400
X-MC-Unique: JHK-_1T_NSSFKoP8KO8tFQ-1
X-Mimecast-MFC-AGG-ID: JHK-_1T_NSSFKoP8KO8tFQ_1788250140
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-482a5e9400eso4239147f8f.2
        for <bpf@vger.kernel.org>; Tue, 01 Sep 2026 01:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788250140; x=1788854940; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XdL8zzc8V9JkK2rUeyT0WO94d4yIRGolbKfwcYc2drU=;
        b=UndXa1KwsSXmtdRExe0WfBAFSE/P0/FqlNM+Ltf6hFwpWyeteYdHriWHNOQs4Mp2B4
         i6Kp8WZuFrSnwsqT0v8rUEsIXqant7y9NWvC51Vl7g6P282Qi/rVBUeNdxMnrDm8rS9l
         c1Y4LaRb2rZlny/Hq7m0mj04+wC16tJRQ9BQjC6wqu9vH7xsUoVtYisIaSiGxiGpeHGs
         MvDni+8Y+A/K9FrSJzXLHd8LwYCu900lbzTGBbhWCTXr0n5fVvgTJa+NRry9ewhta9Em
         MuGLJsJxOXGFbcLbgrzhfjn4V7as5e5HYyEAJNo9rRIazcT/lGlrbdYhZMzhGfmZ2gYB
         eClw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788250140; x=1788854940;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XdL8zzc8V9JkK2rUeyT0WO94d4yIRGolbKfwcYc2drU=;
        b=HvsHvnWArCeZqA793YiEX6oUcWi6z3SKvY0S9qsoEkw0v3lhtUZV8UmUE5HYhVheWK
         ZUUV/zEuNXJDlUeuSvIwsReVjzsCnk0WpimzlV9NROub767+gVlW51PmW09yfpE9YY5N
         VPY1tSLft9z4giq8qFWdUtfsj9mJIeHFEg90ZNvz9hCkygVG/Jktm/yVJVYgR3qT5ImP
         TEZaebnwnKAzy9dsgSPWxrE2BSLH4HTDtX163O4VjxIWDE9ZxCHsvYJyt/KO09pCR5E3
         veOa2jp1IqNlsEhi9kdtVSDpENJQzKmuPSKO7m2J34uM6iyp/O8kHccd/plYqF8gXYQj
         1OdQ==
X-Gm-Message-State: AFuF++kcjxRM75LkVFyRowKOQcBa5dgWj47HKFZP4SepzV7T+92wVcb5
	ZNOlYz5kKj/ung9H5tD5XuRluQNq3D/oTs97svx5B0ESUwHAWQxbHV1EVLnJYIh5L2NdPmVGDmO
	V6r/VRcWUbYDKEkx9oNbZ/Z6VHyV9/ncxlROTq01Pq8NAmM2PseZhPFTGCBqVrg==
X-Gm-Gg: AR+sD13xRr+78Nt2FKcQLdUKqcUDzmww7jcbjLno4k0RP7AujHaNa0xrs+Xzd3ZlFz0
	/0xRoltpTgP+XlA2VtoeW3tyhxAdM6hNlOesjUxR2QhdJYqLYq5U+bla5s0gZWnfmOw81FGIK/d
	CjGRUYXTDlcKgHBkEzILfkQgqsVuSKPr3hxoUSb69pg9orE32Kbh4YPKbFdoJL237PIrku24JUa
	1dpQBRom7tHE1arz105K60EbEXA3BLTN+yB0TcVcRmBrc8JPtnmX7VTpiXKNAp3l6oE+gp+V6gF
	RFqMc7cIwYzYki7L2PkA7w+TbqpPijxOHrZlKtnvuadTP7CeMoxE8y90atPcK69ymdRWcWAQoSK
	2XWY7PtHs7v41OFBtdxh1fBKbW5E=
X-Received: by 2002:a05:600c:a418:b0:499:b65e:49c9 with SMTP id 5b1f17b1804b1-49cdc558513mr105413775e9.10.1788250140336;
        Tue, 01 Sep 2026 01:09:00 -0700 (PDT)
X-Received: by 2002:a05:600c:a418:b0:499:b65e:49c9 with SMTP id 5b1f17b1804b1-49cdc558513mr105413065e9.10.1788250139923;
        Tue, 01 Sep 2026 01:08:59 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cd8148fbdsm74332025e9.3.2026.09.01.01.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 01:08:58 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id EA00497C4A1; Tue, 01 Sep 2026 10:02:59 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 2/4] bpf: selftests: Check for flag presence
 in bpf_program__flags()
In-Reply-To: <20260831134450.680941F000E9@smtp.kernel.org>
References: <20260831132648.65843-1-toke@redhat.com>
 <20260831132648.65843-2-toke@redhat.com>
 <20260831134450.680941F000E9@smtp.kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 01 Sep 2026 10:02:59 +0200
Message-ID: <87y0dlv1os.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

sashiko-bot@kernel.org writes:

> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] Missing NULL pointer check on the result of bpf_object__next_p=
rogram() causes a potential test crash.
> --
>
> commit 357b58adee859a9375d4063d6f64aa4a923e7790
> Author: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>
> bpf: selftests: Check for flag presence in bpf_program__flags()
>
> This commit adds checks to verify that the BPF_F_XDP_HAS_FRAGS and
> BPF_F_SLEEPABLE flags are correctly exposed by bpf_program__flags(). It
> introduces assertions in multiple selftests immediately after retrieving
> the BPF program structures.
>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_adjust_frags.c b=
/tools/testing/selftests/bpf/prog_tests/xdp_adjust_frags.c
>> index fce203640f8cf..a894b1ab46f4e 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/xdp_adjust_frags.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_adjust_frags.c
>> @@ -18,6 +18,9 @@ static void test_xdp_update_frags(void)
>>  		return;
>>=20=20
>>  	prog =3D bpf_object__next_program(obj, NULL);
>> +	ASSERT_EQ(bpf_program__flags(prog) & BPF_F_XDP_HAS_FRAGS,
>> +		  BPF_F_XDP_HAS_FRAGS, "frags in program flags");
>> +
>
> [Severity: Medium]
> What happens if bpf_object__next_program() returns a NULL pointer here?
>
> The prog pointer is passed directly to bpf_program__flags(), which
> unconditionally dereferences it. While the object file is expected to con=
tain
> programs during normal builds, if it does not, could this cause the test =
suite
> to hard crash with a segmentation fault instead of failing gracefully?
>
> Prior to this patch, a NULL prog would be handled more safely, as the lat=
er
> call to bpf_program__fd() explicitly checks for NULL and returns an error
> code.=20
>
> Does it make sense to add a check like ASSERT_OK_PTR(prog, "prog") before
> accessing its flags?

No. This won't happen, and existing code already use the pointer without
checking it.

-Toke

