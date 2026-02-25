Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9217E393DD4
	for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 11:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772017460; cv=none; b=le6pmCcdM5sRdr/kKDgCdtPDoel5wX1J2QhHdpDqnNzeqYOP54tg5vDtjYHYLz+Z8GWyGGhtuD7VUt4U6JqBjkvosnLf0rsY37SvNRrFVgirOoQ+yANilaE4N3xzR3hJvBD9LFDnSBGQ8VULsEmOjaby6vaiUk3DtJr1dVGtx1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772017460; c=relaxed/simple;
	bh=3v6jEXXDFmjA2SzKI3hqvjBUHWcTHQyN4QeAqW2m8G4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o/P7GpUUPe2j8NyR21oX6wFjbGis7u2R9F5wGeIvZnep64n2VoQf/nFwjkLpEHQoYlYsisQzLS73VpZh8w9Gps/QRNZnRIyAwEA+b1yzAaJOi4NKPCNhRDkmh9cOvPZAWQ5qmVJ85CNypzJiQIgIhX4eDftoGlepFBWaZrY98QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Wf/ZeImY; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Wf/ZeImY"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61ONRkZ31176343;
	Wed, 25 Feb 2026 03:03:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=jNxMIlaH3k8mgVhpcmN3R8lUU
	EjX7d+FafvsPM8bdZE=; b=Wf/ZeImYCuVnQAhd7ieczRBnw0bs7VMTtT6Dkgsu5
	RlFI2V8EC3VbP2LX7l7bpiyUzOkDqswiU9lfceOv1ka+JLJVpr1ws5QjavK+MAd8
	5fTFL9+B6wZrJfAv0Dvy4nKjGdfxXK9SfTuUSrzySkD9HwYmXRtn6QYuy/HU2GIo
	757mejG7blswklsvGm415BldJ9+bTW6s7A1KcK0TumKam5xoIm+bZljbeCwn9YDn
	eSYQ3cw2xihAPxVh3dXG7M5g2eIX3blvJFS5yxO87eTs++7FLEL/PVXDiP3ta8X0
	YTFQws5znPlNBbuLT2SKWfQzWLEKoRaM8wy4c1YmYM7rA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4chnp8s907-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 03:03:43 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 25 Feb 2026 03:03:42 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 25 Feb 2026 03:03:42 -0800
Received: from kernel-ep2 (unknown [10.29.36.53])
	by maili.marvell.com (Postfix) with SMTP id CAF213F704E;
	Wed, 25 Feb 2026 03:03:39 -0800 (PST)
Date: Wed, 25 Feb 2026 16:33:38 +0530
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
CC: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Eduard Zingerman <eddyz87@gmail.com>, <bpf@vger.kernel.org>,
        <kernel-team@meta.com>
Subject: Re: [PATCH bpf v1] selftests/bpf: Fix a memory leak in xdp_flowtable
 test
Message-ID: <20260225110338.GA2906962@kernel-ep2>
References: <20260225003351.465104-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260225003351.465104-1-ihor.solodrai@linux.dev>
X-Proofpoint-ORIG-GUID: pJ5zmoy_wMMhlGzoeqdPui5cOa6YqLPI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDEwOCBTYWx0ZWRfX+GAR/p9JvtmN
 msNQM/XvXViEz2im1jvyVKnl2Iv/XMBE0a9PMXWSi4ClSLTCgARN9wgp9fqMVpBEPblDeZVz3rw
 mkWJakgsLaQ9SSVUfR/+4c7lYrSvvwN7/ZoyY/MRW5y/K9gEtkuGJgvBwRL12PnNIMXOB9umfr8
 HRQw8r6xflSJhqFjOI1XciCgmNE+GcwDyUf2pvyXYptoJEcYg0tCt8bM0pZvsT1RMyqioRN4fii
 vag1yy7u2iZiy7k8ZV/261+3/rf4rEM8VsRoIXiLCVvwSPZLHnBT3kYUV0fiGyWJK2qPVzRE+uB
 0zvdSbXvhyDZHmhuayGEvYZDFzTRlyMh4n4PYv+IhgJOG8Hn/kMU2Ve6v/RJAZVxTRipzOW3cf/
 iOcWMzm8xorMvQ1X1Xv4lu8XSUwfzGb/emogHpfDV2mFEAGpOnUvp4FMcHsnMUUGpCxlH68yQJG
 j25KbRL5uZq6Du/xEaw==
X-Authority-Analysis: v=2.4 cv=bNYb4f+Z c=1 sm=1 tr=0 ts=699ed70f cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=NEAV23lmAAAA:8
 a=M5GUcnROAAAA:8 a=rNDjod-Ssv0htqVAcTEA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: pJ5zmoy_wMMhlGzoeqdPui5cOa6YqLPI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_03,2026-02-23_03,2025-10-01_01

On 2026-02-25 at 06:03:51, Ihor Solodrai (ihor.solodrai@linux.dev) wrote:
> test_progs run with ASAN reported [1]:
> 
>   ==126==ERROR: LeakSanitizer: detected memory leaks
> 
>   Direct leak of 32 byte(s) in 1 object(s) allocated from:
>       #0 0x7f1ff3cfa340 in calloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:77
>       #1 0x5610c15bb520 in bpf_program_attach_fd /codebuild/output/src685977285/src/actions-runner/_work/vmtest/vmtest/src/tools/lib/bpf/libbpf.c:13164
>       #2 0x5610c15bb740 in bpf_program__attach_xdp /codebuild/output/src685977285/src/actions-runner/_work/vmtest/vmtest/src/tools/lib/bpf/libbpf.c:13204
>       #3 0x5610c14f91d3 in test_xdp_flowtable /codebuild/output/src685977285/src/actions-runner/_work/vmtest/vmtest/src/tools/testing/selftests/bpf/prog_tests/xdp_flowtable.c:138
>       #4 0x5610c1533566 in run_one_test /codebuild/output/src685977285/src/actions-runner/_work/vmtest/vmtest/src/tools/testing/selftests/bpf/test_progs.c:1406
>       #5 0x5610c1537fb0 in main /codebuild/output/src685977285/src/actions-runner/_work/vmtest/vmtest/src/tools/testing/selftests/bpf/test_progs.c:2097
>       #6 0x7f1ff25df1c9  (/lib/x86_64-linux-gnu/libc.so.6+0x2a1c9) (BuildId: 8e9fd827446c24067541ac5390e6f527fb5947bb)
>       #7 0x7f1ff25df28a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x2a28a) (BuildId: 8e9fd827446c24067541ac5390e6f527fb5947bb)
>       #8 0x5610c0bd3180 in _start (/tmp/work/vmtest/vmtest/selftests/bpf/test_progs+0x593180) (BuildId: cdf9f103f42307dc0a2cd6cfc8afcbc1366cf8bd)
> 
> Fix by properly destroying bpf_link on exit in xdp_flowtable test.
> 
> [1] https://github.com/kernel-patches/vmtest/actions/runs/22361085418/job/64716490680
> 
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>

Reviewed-by: Subbaraya Sundeep <sbhatta@marvell.com>

Thanks,
Sundeep
> 
> ---
> 
> This should've been part of the recent series. I missed this locally
> because the test is skipped if nftables is not installed.
> 
> ---
>  tools/testing/selftests/bpf/prog_tests/xdp_flowtable.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_flowtable.c b/tools/testing/selftests/bpf/prog_tests/xdp_flowtable.c
> index 3f9146d83d79..325e0b64dc35 100644
> --- a/tools/testing/selftests/bpf/prog_tests/xdp_flowtable.c
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_flowtable.c
> @@ -67,7 +67,7 @@ void test_xdp_flowtable(void)
>  	struct nstoken *tok = NULL;
>  	int iifindex, stats_fd;
>  	__u32 value, key = 0;
> -	struct bpf_link *link;
> +	struct bpf_link *link = NULL;
>  
>  	if (SYS_NOFAIL("nft -v")) {
>  		fprintf(stdout, "Missing required nft tool\n");
> @@ -160,6 +160,7 @@ void test_xdp_flowtable(void)
>  
>  	ASSERT_GE(value, N_PACKETS - 2, "bpf_xdp_flow_lookup failed");
>  out:
> +	bpf_link__destroy(link);
>  	xdp_flowtable__destroy(skel);
>  	if (tok)
>  		close_netns(tok);
> -- 
> 2.53.0
> 
