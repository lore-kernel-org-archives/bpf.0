Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5891731AAAA;
	Sat,  7 Mar 2026 01:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772848527; cv=none; b=eFPkCrtp0o7MMi4TE9atq/pwAXIYgK1AyHv26IoijkwC9E6CYY+ferQ+IHPDCLbX7Dh84MUOj0TtorXdb2s/pcV0p3Ye0qb45g9LsFmxjPHkSTt8J0CswLAXMoNF6b0PA72gY0zZNKZB5WEti0Amu9CYrHJToygajHoGefqs8+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772848527; c=relaxed/simple;
	bh=XVN3nH4qg+D4tMd3gcdzpMvUjkQbzscyxApzwJOekuk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Sqg4ALkwVN5dvzYE1ydG2/ucwC+fjAtT9tFfuJtI4piEi1oTlllXmcxTdqETzf+xAiI6X7MLDD8iLwKKAfuX4536iP5qMMkXlCjON21K1Ak0GNLYg6zsHkrO3ApWGcgd7yf4azcKL3xyCZDMpOdlJCFdKiyGVN7HjNzpXfPRErQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=BPyu2yUv; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="BPyu2yUv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=U6DoWm37H++4dH+vDQoXURRD04KeM3Sveq3hB5ij1fY=;
	b=BPyu2yUvb1NNgKq+H7HUk4yBtTsa5fs6+u32YRqUGUOz9G2B4ToJP6hxxbIkbQ
	thvrdpStum0Fgz6CW5fCvwj6idg4Yb0g5PWjLGIx8oC3SUQZBaSG8KcJvcnTLv3t
	vhJ9enPsSj12+Oiq83LZQdKO5zsQpcH2MzS+8yDmG3Hyo=
Received: from ehlo.thunderbird.net (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3H_pLhatp4CDSBQ--.64382S2;
	Sat, 07 Mar 2026 09:54:20 +0800 (CST)
Date: Sat, 07 Mar 2026 09:54:18 +0800
From: Zhao mengmeng <zhaomzhao@126.com>
To: Andrea Righi <arighi@nvidia.com>
CC: tj@kernel.org, void@manifault.com, changwoo@igalia.com, nathan@kernel.org,
 nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com,
 emil@etsalapatis.com, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev,
 zhaomengmeng@kylinos.cn
Subject: Re: [PATCH 2/3] tools/sched_ext: Update scx enum autogens
User-Agent: Thunderbird for Android
In-Reply-To: <aarnUtBe2klutXLm@gpd4>
References: <20260306073110.229595-1-zhaomzhao@126.com> <20260306073110.229595-3-zhaomzhao@126.com> <aarnUtBe2klutXLm@gpd4>
Message-ID: <7C4C6EC7-258F-4EB4-ABEF-89897AC56D9E@126.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID:_____wD3H_pLhatp4CDSBQ--.64382S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF45urW8XFy3Cw15JrW3Awb_yoWxurbEkw
	45Zr1kZa98Xwn8WrWYkrZ3GrW0krnxJ3yrXrWaqrW7Zr15ZFykAayqyrZY9rWfWw4Iyr42
	yF1kZwn0yF13tjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRR1CJJUUUUU==
X-CM-SenderInfo: 52kd0zp2kd0qqrswhudrp/xtbBqwy5MWmrhUyAkAAA30

On March 6, 2026 10:40:18 PM GMT+08:00, Andrea Righi <arighi@nvidia=2Ecom> =
wrote:
>On Fri, Mar 06, 2026 at 03:31:09PM +0800, Zhao Mengmeng wrote:
>> From: Zhao Mengmeng <zhaomengmeng@kylinos=2Ecn>
>=2E=2E=2E
>> @@ -46,5 +45,5 @@
>>  	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_LAST); \
>>  	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_CLEAR_OPSS); \
>>  	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_DSQ_PRIQ); \
>> -	SCX_ENUM_SET(skel, scx_deq_flags, SCX_DEQ_SCHED_CHANGE); \
>> +	SCX_ENUM_SET(skel, scx_enq_flags, SCX_DEQ_SCHED_CHANGE); \
>
>This is wrong, SCX_DEQ_SCHED_CHANGE is moved from scx_deq_flags to
>scx_enq_flags=2E
>
>-Andrea

Thanks a lot=2E  I will send a v2 fix=2E

