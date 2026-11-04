Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.54.127.65
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793822096;
	b=gHHM2hRo+eMeRoKpv6K10DO/3JZrjbdwb56ZvfL3cSy30msN0uuZxwe6AAwc4TBtH4+9
	 KR5nIUTCmlilrvorY8iVCV3DRMijwGdVqw7VRHFy9vPtadWEn/mShEkHt15rk4Vfoh4yB
	 NcWFA1ihGPX9iHXJl4vnxzUNPm+4DM9bNMP0BmkFMI4FzdHC4WJvGMvXAUbuhleDl2aqX
	 E+hHs2HjhagYvaEYWm5ifjBasRzF9fnTNalWHdXD5/KJlpWOt7Kh4wU52TY78Eo/ReG2/
	 4pW9JXUJWtLD9wzeipGVR/NtSS/+UmQp7/gQOzgmvYnRfn7vDyek6YR9KtrJWv6++DQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793822096;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-Envelope-From;
	bh=VcIN67GTsXNoBlIaq3XR45xamAJGvyioRTJR7elGh3o=;
	b=1KKRVwwQvFuwqYGIhZA6R5eXnsr5GkFFeJV95IgbtSyBQjhcx1E07uxBGkagrjtvlGi2
	 uKl+enfdGe4gxLSFuflUaU3FokKZICMyEi7WuSkdBj2k7U9kz5aVQnYGHrP7DJSjUVgp9
	 i0QinT5+s5NFy6nR29Dc+0B58uU/geceYU+I8Sw4pNn4cnDpvgY6ml34HK2KkZqbp9VSb
	 qfaPauPA0xlOxUmtYoQ+vWoMzcbvfdRW0N8KsNIeMzRJDn1ROoFCftqxZD426KZNkjr2D
	 rdFBiYmzlf/rkn5/fYxkWLuIaJBnLPX8B8Qby5M7Dqh6Hk6S01pfqAP8l+EmOeyYcsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tychen.cc;
	spf=pass smtp.mailfrom=tychen.cc;
	dkim=pass header.d=tychen.cc header.i=@tychen.cc header.a=rsa-sha256 header.s=spacemail header.b=RHg09mAj;
	arc=none smtp.remote-ip=198.54.127.65
Received: from out-zbxj-a65.jellyfish.systems (out-zbxj-a65.jellyfish.systems [198.54.127.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED816098F6E
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 19:54:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7ED816098F6E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tychen.cc header.i=@tychen.cc header.a=rsa-sha256 header.s=spacemail header.b=RHg09mAj
Received: from [10.18.116.108] (ec2-52-197-241-54.ap-northeast-1.compute.amazonaws.com [52.197.241.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4jKbkN3vlzz8sWP;
	Wed, 04 Nov 2026 19:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1793822077;
	bh=VcIN67GTsXNoBlIaq3XR45xamAJGvyioRTJR7elGh3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RHg09mAjYsx4Pwn+Nc9DwHrJxykhKlfzao6gaFRJZunJyJpCpAXI4dHlpV4bxyVGm
	 5B1SdMxZaI7ag+8vPKB1OuBXqwgY8/UpWj8BQOhHFWwk8nhbFGRrgjmHMwjQK+tezR
	 0KlzqNkfB3/WUgoyArnTPz4eIeeD/Dd2yNsT3egzjNwPC81+4YExe5qReIErztReLJ
	 wrPOTwcBBXjbhdIKGM41LXzRY3s8bcPynV0HJUSel8TtRlvZ+RhM24tjibdOGXmsNB
	 Fv9pRENJIf6D22fBC6rattquwPwzCW6+z0zLOrKLJHGWVDFB1KofOnnBHAFyFcmYUt
	 SFHIdfXJcT1fQ==
From: Tianyi Chen <hi@tychen.cc>
To: sashiko-bot@kernel.org
Cc: hi@tychen.cc, bpf@vger.kernel.org
Subject:
 Re: [PATCH bpf-next v8 2/2] selftests/bpf: Check bpftool batch map dumps
Date: Thu, 05 Nov 2026 04:54:12 +0900
Message-ID:
 <179382205294.440318.17988073505184009869.bpftool-batch-v9-review@tychen.cc>
In-Reply-To: <sashiko-outbox-197940@kernel.org>
References: <cover.1793818387.git.hi@tychen.cc>
 <4b2b24fdabd4cdef1364a8664d7d9615e960c72c.1793818387.git.hi@tychen.cc>
 <sashiko-outbox-197940@kernel.org>
Content-Type: text/plain; charset="utf-8"
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
X-Envelope-From: hi@tychen.cc

> Would setting opts.map_extra = max_entries for BPF_MAP_TYPE_RHASH avoid
> scheduling background resizes by pre-sizing the rhashtable to 256 buckets at
> creation time?

Yes. A smaller in-process comparison after 100 inserts, with no further
userspace updates, produced 25 count mismatches in 1000 runs; with
map_extra=100 it produced none. The complete old bpftool subtest passed
50 repetitions, so this is not a claim that it fails reliably.

v9 sets map_extra=max_entries for RHASH. The updated subtest passed
100 repetitions.

v9: https://lore.kernel.org/r/cover.1793821981.git.hi@tychen.cc

Thanks,
Tianyi
