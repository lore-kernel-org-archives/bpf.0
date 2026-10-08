Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E3B4657E0
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 09:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791450062; cv=none; b=gYtWGE1zzpfqaNMykzeZSxaMjgygMiErr1JrccUrDJyaKZoThLY/5lAGdGI+wpmOhY8fP/0iWatk9vBLDKqKdmqFb3/LqYRekobj0vbzgbQFWwWDjclRLoODtSk6b8qq3R7fTD2GoJYU2Jk8+M6yW7ii7uvPzhgrnDIzDrHApD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791450062; c=relaxed/simple;
	bh=bubMmErBBviwm0SDj7HwGRRwgU0dS+pqJdsiw3r0uFY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ZGQXxLp0+PBL4/aDWBGe5zqcfEsjeAubD0cj1mxRnXUvS6d/3siAcGoxtiVztNRg5NFwnFYMLxqqPRhhtMlm2oksgG29f/x38Z6f0cI729c1GxrqIqZ5qQrJ+BPmiYV/nW48K+YoysWqYXhRRVU1iw5DKHOttGnaDPVMfNioDLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WG8HzKFG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bILFnGBE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WG8HzKFG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bILFnGBE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791450060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bubMmErBBviwm0SDj7HwGRRwgU0dS+pqJdsiw3r0uFY=;
	b=WG8HzKFGQfbbglSQQ3dhi7KmsihXj7dBBIcjDIUP47Nfp5s3/3EwvgSN8wSAFJmctriJ+l
	SWxLtfr0xoeOiTPHqbr/N/glVKKC6fNUshrCkmKuxcVMSoHFqkU8v0Ua+tdEBPtpfe8ckm
	+CX0q/+G7EN66XnmlcS0nCaVaBmbPcg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-QFA9qUyAOPSRqE4Quzcbow-1; Thu, 08 Oct 2026 05:00:57 -0400
X-MC-Unique: QFA9qUyAOPSRqE4Quzcbow-1
X-Mimecast-MFC-AGG-ID: QFA9qUyAOPSRqE4Quzcbow_1791450057
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a1612c4b80so47924545e9.0
        for <bpf@vger.kernel.org>; Thu, 08 Oct 2026 02:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791450056; x=1792054856; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bubMmErBBviwm0SDj7HwGRRwgU0dS+pqJdsiw3r0uFY=;
        b=bILFnGBEfFnqdXAHCC0WgdHHN1tzxghGY7heSU2005jQr3O9az5k+2Ki0x4tE51fKF
         8/8IU5+xJWYnMFJoPQFyGn0KII98FIpGIOARNOX20+TM4WuROnWCXqLmUDsMZjuDtCj3
         D4+pm01qgeNDSUdSrOrm/gcjb+QRGM3hovkVnH+b54v6WEdIgZU6sS+iC0ZaUMPQQZ3a
         b0o/5XCTfeRFVh4eM+8cC5gAK6uRnIoaN+Ra0Dyz0uPtolPoF9thhYDv7Nxia4EqjH0m
         Uyy2h2TUDH1aGNiUKupcOSUWm0jLq5EBsMpJwJGSr0HHzSKDx1p0eCQcwYyLE678oUdq
         5vAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791450056; x=1792054856;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bubMmErBBviwm0SDj7HwGRRwgU0dS+pqJdsiw3r0uFY=;
        b=Shzzh0hFhgAIRCRIT6xAwytguo9yTGiTMNWBQMt6U7P6vCdgeWB0rwhQcxitFFfkME
         GMw5OjAgv/X01j1GY5Dd7V150358aYXh/mxeSu8GTS6NHn/5R9umIW49NzaF4QLq6/1G
         /e5/yZGMRI76m7Ce3n/McwXu3xxBjLyvEMuy1wGXqQxz2kZeMHkC50UXTIBlchcCFUAD
         HanZqqvRm2GM79UvXVwnvMjBf9pa01uOx1TFVHwFQHOTK5By7TcMmg2Il1+swHoMinpI
         pu4Y19gfNLBGpm3BjblV3kkRCn++maeanEetVSpE5Vo0AseIG7CL2kN3nxaVeuJVsmKf
         14vA==
X-Forwarded-Encrypted: i=1; AKwUvBwlnnDdgjTLGGWXWGdwWfrQ0zNsQZ+yDcR5w+PlyBJ/RUtv2UYYft0I9Mn9rFraAq0zswA=@vger.kernel.org
X-Gm-Message-State: AFuF++l5F2NmuHwv0i6jebiyguw3DTgyZ1rZlGwwQyEakwHAYUS1/ag+
	M/5sK1a21WsFVrHwX+rQiKcZ5UDCVzDbH+uJuWUyRMzINPeacTDaNmgwiNR2uEadVP164IWSrPw
	vBGBSlew+slX3ZwWVnLEjjL5dyDsOKQAaxUZMDhrn7ECsoPo5NLfxiA==
X-Gm-Gg: AYBFou36XTBab+4oyEaY2u3/M34LOtOUx79xtIHqi4KaGWPFfPNfB8Xq9wdLkuXE6np
	Tocxo1yuIbm7WmjheRMqn9wXuPggIUrDveOeueThb3mqpFIq59ZB3+P3b/e5HcmfC2PbuySO3jM
	rm6USq71Eb1aQCr5X4XTyv9YequQJljBplNqxA4eoMpaFau2E6KP45mYa9yGz2AMhpKPyIAAiBb
	YOY374xei/VIN3TeLqS+i16eSu0udoOl3ygLZJA0eNa0aVsSP19RCWA3e8rmz8WjGgkMzD/0REq
	e0I8ldSWlTlaqbMlkgTwZEH6LKpNCE/ZE6+UKMujz9H8ewwsz8fnXby14wEfgDSvY4RqMDLNL0Q
	t6kS/VKRl9MbkbkDD+87SZFaMrcknrbqzvOGt
X-Received: by 2002:a05:600c:548b:b0:4a1:71ab:63ba with SMTP id 5b1f17b1804b1-4a18045f729mr85522875e9.29.1791450056562;
        Thu, 08 Oct 2026 02:00:56 -0700 (PDT)
X-Received: by 2002:a05:600c:548b:b0:4a1:71ab:63ba with SMTP id 5b1f17b1804b1-4a18045f729mr85522395e9.29.1791450056135;
        Thu, 08 Oct 2026 02:00:56 -0700 (PDT)
Received: from ehlo.thunderbird.net (mob-5-90-15-200.net.vodafone.it. [5.90.15.200])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d3d3eesm11480317f8f.53.2026.10.08.02.00.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2026 02:00:55 -0700 (PDT)
Date: Thu, 08 Oct 2026 09:00:54 +0000
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>
CC: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Wen Yang <wen.yang@linux.dev>,
 Tobias Schaffner <tobias.schaffner@siemens.com>,
 Viktor Malik <vmalik@redhat.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_09/15=5D_tools/rv=3A_Copy?=
 =?US-ASCII?Q?_stripped_bpf=5Fatomic=2Eh_from_libarena?=
In-Reply-To: <87ld89wtrx.fsf@yellow.woof>
References: <20261001152042.124445-1-gmonaco@redhat.com> <20261001152042.124445-10-gmonaco@redhat.com> <87ld89wtrx.fsf@yellow.woof>
Message-ID: <4F009BB7-58C2-4AB1-8FEF-61FA4B5281A2@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



Il 7 ottobre 2026 12:59:46 UTC, Nam Cao <namcao@linutronix=2Ede> ha scritt=
o:
>Gabriele Monaco <gmonaco@redhat=2Ecom> writes:
>> Add bpf_atomic=2Eh including atomic read/write macros like READ_ONCE() =
and
>> try_cmpxchg()=2E This version is a stripped down copy of the one curren=
tly
>> present in selftests/bpf/libarena=2E
>
>Instead of this, what do you think about using C11's atomic stuffs? I
>prefer standardized stuff when it is an option=2E

Mmh, I'm not too familiar with them, but they wouldn't be drop-in replacem=
ents as far as I understand=2E I'd need to use C11 atomic types and that wo=
uld diverge further from the kernel implementation=2E

Ideally I wouldn't like to copy libarena's implementation but I couldn't f=
ind a cleaner way to include it=2E

I'm going to look into that more carefully though=2E

Thanks,
Gabriele

