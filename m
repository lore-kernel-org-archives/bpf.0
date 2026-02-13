Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974B51EA84
	for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 00:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770941693; cv=none; b=o/AyCG655rhD4RdGfHWvPW1/ZTh4wgKpIjNsG6hM5axbsh/WGK4c5pvCcwq+U2TnIOYj7QZYirkzF3cZTqPMrHsNBytZMtn+c28a3rOjy1owehFKgrx51dIGTc9PPbRlQt8wy6gSBkVGZ8UWNjVaDe02AxQ+3InSnQTHDkl5u1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770941693; c=relaxed/simple;
	bh=m2a6CuMCos/13elBxE7xrPOeupdB2O8QuOfKeNHD2Rk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nnf0EWfUy0hghEV+kV0O/otbYdkykYxPT/xs6jNVs196Ei3Kbl0jtmnRXyj5THtheJvZFzlKfPi4FKabARi7tLOP+nK+DUzSOTwyBy5BxYjxuTpaC4jO6BLy+YUC8S9HkS1FnhGerPLdOYekV8+m3rNXUFAHBHQpwFDFA7zd+nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZjI057fn; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjI057fn"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-124a95e592fso1319988c88.0
        for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 16:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770941691; x=1771546491; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IZOOjMHRTBJzKVIedfGL7gf236fJildms0DgDpjegcI=;
        b=ZjI057fn6h9yR2vnjUPjY/WBMFRNYjcB0lvj0WYarA4n5O8S0CUIPG3pMALzhbnmYh
         Sqzut951tUjbWUZk9dc02lmbBJx0XNiwLMiMoAZB51aCOnSN+1XmmZlEXCbvBZs8POZJ
         EYtlvQvTOuy5A8kFDIf5L68JoRhlejB/UL4hj7s7BLIvvIddePoDe68yomwbwuq5Z+ji
         Mqc9q7U7VWFYjELWCOv4RBPlWtUOuSkvds2xHY1mSu3JyFv6yaI6kQgxTkG2AqoWSfUZ
         MPp34XsQrBIy1v49tNXMl4AnnRBlT0cJKE5zy0AFTQIWfIfdmcHVO9qfHrPrScZ9svLv
         gDqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770941691; x=1771546491;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IZOOjMHRTBJzKVIedfGL7gf236fJildms0DgDpjegcI=;
        b=R1liLd2bAk0JjY3i/aoQWma5rURm8TGcRx4XFEwmVWgH1vJQFO6At8MS+9oGuNIjlj
         PbtWpp33VwBoFUcpxLZ7XSQV2W+Ml4fZohi5z6maHrr5WSX/t4SxNgSbwl4/CnVM5DvF
         asoEO9OuCG0WZBQ4uEo70kiQ5Oh02g3Tor+Vv3Wf1OMcnD8jyzmtA939uOsSUTaA+ui6
         76iKvkwdQ3Ae2v89P+sZKAVICexrSdIm8w97UpBgWvjHgf42Xa8RKyq2DGR0CTGm99fB
         WvJ/QAnY1lIQthimhaoGOY1ykEMLy6U/QA3Uk1qsfor5gLIkn8g2ao/FY57fomZKHSXb
         7CxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkey4ZeX08tL0kEO42eRym3yQbaxQn3sAnDcYX31En6pSUBy4canaWb3Q+cpVg0/Gy2Xc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZrcSe6nnYtz4geMIAVvb7mqnAZI/6IIzRb9ozzf7aAzCtUENq
	FHKvAx2msZQ4ghGpdMFvRbNTbXSt7QrA/ROc9Aj4lDiT5+MgqtyGNrtB
X-Gm-Gg: AZuq6aJRC2JPKgbykkhsSUD7m7S8pQWJklLeC4cveOTGbP6Zt3aodHVIqr4FNL57MZF
	MlsnbIlQlCv8V9YIekCciyKTJXO/0lZrYx+idykHD59EcDdrRvOQoZrWjSGNaIeHGvUFASIOwIV
	7xsKLKSfM2+al69S9t+zBnbapTO5q+pyUzeU5XAX4EB1oHF+e5WYb5ywXeZjCeslWkQX5cOYzpc
	WvDl1al5FEw+sZC5pbT51QCwhKPieFAtWZuKAg4ykciOgwZgT/DITiY5RvmTSoksWrHyzLZESK+
	z+aPeC94bZAXweaiizgK2K3/P5f0zwoAxUw6UGfzkDXLapMcmSwyc/nQoXrAK0cvcYBmb4q0C84
	aBK5nFyOXQBaT1vpMCpe0/k3iMqF1Xu1aUozje3zcYBO38JRkBcwVCyCNzQICHLxexA1sGOpicU
	F+Z6RXZJWCwvcJVA58IT7zbO+j8k+n1Kq9
X-Received: by 2002:a05:7022:690:b0:11b:7824:5c97 with SMTP id a92af1059eb24-12739846637mr323128c88.40.1770941690599;
        Thu, 12 Feb 2026 16:14:50 -0800 (PST)
Received: from [192.168.4.196] ([73.222.117.172])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1272a636095sm6909624c88.0.2026.02.12.16.14.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Feb 2026 16:14:50 -0800 (PST)
Message-ID: <e49fc187-0ef8-4557-abac-0082653fa645@gmail.com>
Date: Thu, 12 Feb 2026 16:14:48 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/3] selftests/bpf: Check
 bpf_mem_cgroup_page_state return value
To: Hui Zhu <hui.zhu@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Hui Zhu <zhuhui@kylinos.cn>, cgroups@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <cover.1770883926.git.zhuhui@kylinos.cn>
 <042df9438d9e78bcd66f1fa0e7043b9ea8cda96c.1770883926.git.zhuhui@kylinos.cn>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <042df9438d9e78bcd66f1fa0e7043b9ea8cda96c.1770883926.git.zhuhui@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/12/26 12:23 AM, Hui Zhu wrote:
> From: Hui Zhu <zhuhui@kylinos.cn>
> 
> When back-porting test_progs to different kernel versions, I encountered
> an issue where the test_cgroup_iter_memcg test would falsely pass even
> when bpf_mem_cgroup_page_state() failed.
> 
> The problem occurs when test_progs compiled on one kernel version is
> executed on another kernel with different enum values for memory
> statistics (e.g., NR_ANON_MAPPED, NR_FILE_PAGES). [...]

This patch looks good but I think to fully solve this cross-kernel issue
we should use co-re in the bpf program. In your second revision, can you
add an additional patch to make use of bpf_core_enum_value()? This way
instead of relying on enum values in vmlinux.h at compile-time, we use
the btf info at load-time instead to get the proper value for the given
kernel.
