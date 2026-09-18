Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8209502D78
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 15:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789746083; cv=none; b=BcU11xi4zI6fgUwM+dms0qwh+HvI/KLFUeqSP2rGtUwlSe++GjJ2HjcKEnNmTJS/Apc24t7KVHLDlQGlH8cjptAETs6R9YMSkMEmyPCoF4rfUx8NVYN+WJVVB21NA8+yGfAuYPF+0h8VFWqi1Ozx6GJ2w/vl4HQSrZ05VnS1930=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789746083; c=relaxed/simple;
	bh=Y8Xjd/wgp9Nah/nB1NJzJuAt+HbSpuz0SOhh9XDTuUE=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=D2HI19OydffOuiL+mSY/o2D12FNDw3JOj/XaXurFu/eDe9n6lu+/icfntoRGtpSgtHDxxojHLYspXZdsQb4+s9EIHbd9xyuSCs4yvI7INGQCARiG7DksMLaw0lljvaTZWrXiacQMhQFczWPTRyj0B64JVRJT0mt1uxiEGQrgHnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LxZR7fuW; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LxZR7fuW"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f70553dso119662266b.0
        for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 08:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789746080; x=1790350880; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NTqpDCleJIN6xxRKbyrEn0918f3th1MJEGdTO5nWLlY=;
        b=LxZR7fuWUx34aAAOJWoo2ZQxWcfOqNxAE81QqsJqWZNfWLR4u+J5wiNdmdWp7adXis
         8GIP28cEyRjlmrW8XDx1Hnn6mb8VKqqJVePDJbcVylMLSDjRwLUBYlVqnO+LhlNkXoOO
         2RZoCbdKNKnVfsdabvZFa3DzwtHtBvsxIbDrJiBNRyHlSd2KOSYVqKoMnpuK4cR0/aQb
         9CQIA5LuFx/yvMnfNlejM2zAaHdIPmF88NWQ98HEzULZ7EHivOD858B1UnjuGgy/9G26
         ycNlDLMjwQFUj4hRjH9elsJomXEfCUM5OElUIWmJ+SM5eXqhMTdNIY0RNzPHXO5I6hu4
         g56w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789746080; x=1790350880;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NTqpDCleJIN6xxRKbyrEn0918f3th1MJEGdTO5nWLlY=;
        b=TpcO0rI9k5Es11AvHlBZYuPINbtONt/Is85xyonSAU6usm8dTKj/5yIpCLuKYsLSHc
         qHjFu4OoQ07SyE0pZQqWOqBeWPn4JMaKXsHxpMnNv73XCiPGWTU2gLwS2Xu1L55TmAhF
         VEaqGQ08ThgkSzCOCkfx2zI27IVOd+tukzy6GXx8zylTBmtt6uQR/URfGDesOqyGaBqW
         hBIupajCat1G0M8SaQYdy6abPV1Y5gXU/hKmkqnLGwa/nDJf0GveZHcVkAEuIE60JfN0
         HzdJV6TSkwjY+CYacB1QGfVHmBUFK4Q2ULAp9uacq8qo46NYb37l2odvWPOX/Pqq6L2s
         u1+Q==
X-Forwarded-Encrypted: i=1; AKwUvBxnx2c9G/j+PjSJPGCECI5VO7zVDYy5sW3B60c01x3F5KuzGBJWjKDggz9B8iCKTE/6A20=@vger.kernel.org
X-Gm-Message-State: AFuF++kdH5xEhRoMvByRHStDfGMd98DZZpor9roOacZddDXI6Qqv4Tbf
	DFiArv3cHiHKkV/1iyGEWRwPQBYJnt5aJvaHY5gpzd/j/NlvSZv6Y408
X-Gm-Gg: AYBFou3nViVm+tcPalr+GEIksI82Us4/B70xa0Mw243I7WH+pe7gmvI6wVmM/T10jfb
	sKhEumbpiz1ew0kXpOBnhgJzeWMtrIzCPBTdUmw6VN+i1xqqkDnRpwwo/qDYgY5gnmMsa1NF/zD
	aMp5dCoFXCw9bJI/fygOzOQeEKogSW0x/LmAraquZIVIdgNbmsNKYrsgVDcxc+q+O2VBoCqkMWK
	HDGwf539c+b8kuAdV5h5cJOgKgxRpd2FCNeSyOo71YlU/TOY21pyOPnX6cw9/bvfkWOtJcvRwzB
	cZ4vh3t8o5i0pGnB91dpPAgiCZQbtryqPFkGjz2a3QyqsAomnt1cI3OR77oV6BGEqMkXJ3ebOPR
	sZKE0yCLjziPw1WeYf+QqrPRTsryTS5Nka88c0Jpas4G6Ib1wFwWl6GYxdurM342VIpPHO8gQjI
	/XEdff02JF2IWIbTTYS+HK4JT1DsspOGp/PTV7U2zjsAc+ilC+yh3iOAEfs/u6Br/ljRCOPp9m+
	feBe16lXFcnXqx5BwXAWpzLCPYrlyTBNT1ai74YlimG3C03TzDZBaHRSHVfNZTQ/3EZ5Jr+Sdmw
	r/JV
X-Received: by 2002:a17:907:9703:b0:c26:219f:6f74 with SMTP id a640c23a62f3a-c2a15846232mr267272966b.5.1789746079628;
        Fri, 18 Sep 2026 08:41:19 -0700 (PDT)
Received: from localhost ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2a1bb08165sm80235266b.22.2026.09.18.08.41.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2026 08:41:18 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 18 Sep 2026 15:41:12 +0000
Message-Id: <DLIK17AFECZV.3U5UY0LYU5Y5O@gmail.com>
Cc: "Hui Zhu" <zhuhui@kylinos.cn>
Subject: Re: [PATCH bpf-next v12 2/2] selftests/bpf: Add memcg async reclaim
 test
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Hui Zhu" <hui.zhu@linux.dev>, "Roman Gushchin"
 <roman.gushchin@linux.dev>, "JP Kobryn" <inwardvessel@gmail.com>, "Shakeel
 Butt" <shakeel.butt@linux.dev>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Ihor Solodrai" <ihor.solodrai@linux.dev>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa"
 <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Shuah Khan"
 <shuah@kernel.org>, "David Hildenbrand" <david@kernel.org>, "Barry Song"
 <baohua@kernel.org>, "Geliang Tang" <geliang@kernel.org>,
 <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>
In-Reply-To: <44f7fcfafd5f33072dd2b9abc31aa9bf5eacd9bb.1789714023.git.zhuhui@kylinos.cn>
References: <cover.1789714023.git.zhuhui@kylinos.cn> <44f7fcfafd5f33072dd2b9abc31aa9bf5eacd9bb.1789714023.git.zhuhui@kylinos.cn>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, Sep 18, 2026 at 02:58 PM Hui Zhu <hui.zhu@linux.dev> wrote:
> From: Hui Zhu <zhuhui@kylinos.cn>
>
> Exercise BPF-driven async proactive reclaim. A BPF program watches the
> refault stats of a memory-pressured cgroup and, once they grow, reclaims
> a second cgroup from a bpf_wq callback through bpf_proactive_reclaim().
> Pass/fail rests on the reclaim counters. The workload timings are a
> benchmark, not a criterion, so they are logged only under
> TEST_MEMCG_ASYNC_RECLAIM_BENCH=1, which also runs a baseline without the
> BPF program, recreating the cgroups in between so both runs start cold.

[...]

> Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
> ---
>  tools/testing/selftests/bpf/config            |   1 +
>  .../bpf/prog_tests/memcg_async_reclaim.c      | 890 ++++++++++++++++++
>  .../selftests/bpf/progs/memcg_async_reclaim.c | 327 +++++++
>  3 files changed, 1218 insertions(+)

1200 lines of selftest for a 20 line kfunc ?
Sorry that's an overkill.


pw-
bot: cr
