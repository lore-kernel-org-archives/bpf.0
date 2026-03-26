Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F01F35F612
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 08:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774513065; cv=none; b=OLyymk6z/bjvnZGul+dtX02EbJmtqhN7GQE8xRmZMg7WIbphr5JUBcCeVSrpcd7S/5gM14eLccjliPKXu2CVsY0O3Nzwmx3xD8pR4Va0O1+D/lHboXOHPOnZZzwt0HWRFhAsK9pX/PUL/tG5PDewbtVRCEwQZkWz5zoKhXNMcxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774513065; c=relaxed/simple;
	bh=sMFWXFO6cLuww1GusJy3mbB7SNxCe+Q9IO/iui2X94A=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=eYxtXATt89YGctg6iBnWPEMEu/+aJiYxt25J5qQ7uR0khTnRsRbcFj6AevAHW9J2UskxO439pIw6GOHh9+n00J7tWSV1qqQNUXg1df1iuRZmbArfXHl3AY/UqS+cXLpSbozalKgwhU3zMTCr0VSC0jXmakG/SrM8E0hEw6A5pgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mZpGm7uf; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mZpGm7uf"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774513061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+cjXlOnP+xsK5fVXd4CCAeINLx8Rs+T12Wp3tIQpO1U=;
	b=mZpGm7ufgnlHUJfxVJ8pxUf6piil/vXgiBaxibhYcGgKSx8pRzxwv4ceQtAsYCsHYWyzYQ
	+vJd6EV8CXWdLfmN24ZFBblr6oUyse3RDML3abxEnm1D/YxXgri8bQ57Uy5DyfvNfS0+c8
	zTFrkDB6myL75CMMptHGPnu6ncrQLrM=
Date: Thu, 26 Mar 2026 08:17:36 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "teawater" <hui.zhu@linux.dev>
Message-ID: <2755fdba5839e9f5ea654e2fe7a7853f990f194c@linux.dev>
TLS-Required: No
Subject: Re: [PATCH bpf-next v3 06/17] mm: define mem_cgroup_get_from_ino() 
 outside of CONFIG_SHRINKER_DEBUG
To: "Roman Gushchin" <roman.gushchin@linux.dev>, bpf@vger.kernel.org
Cc: "Michal Hocko" <mhocko@suse.com>, "Alexei Starovoitov" <ast@kernel.org>,
 "Matt Bobrowski" <mattbobrowski@google.com>, "Shakeel Butt"
 <shakeel.butt@linux.dev>, "JP Kobryn" <inwardvessel@gmail.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, "Suren Baghdasaryan"
 <surenb@google.com>, "Johannes Weiner" <hannes@cmpxchg.org>, "Andrew 
 Morton" <akpm@linux-foundation.org>, "Roman Gushchin"
 <roman.gushchin@linux.dev>
In-Reply-To: <20260127024421.494929-7-roman.gushchin@linux.dev>
References: <20260127024421.494929-1-roman.gushchin@linux.dev>
 <20260127024421.494929-7-roman.gushchin@linux.dev>
X-Migadu-Flow: FLOW_OUT

>=20
>=20mem_cgroup_get_from_ino() can be reused by the BPF OOM implementation=
,
> but currently depends on CONFIG_SHRINKER_DEBUG. Remove this dependency.
>=20
>=20Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> Acked-by: Michal Hocko <mhocko@suse.com>

After dropping this commit, I applied the remaining patches to the
current bpf-next and ran the selftests.
Everything passed, though the following warning was observed during
the build:
make -j 30 -C tools/testing/selftests/bpf
...
  GEN     /home/teawater/kernel/linux-ebpf/tools/testing/selftests/bpf/to=
ols/build/libbpf/libbpf.pc
Warning: Kernel ABI header at 'tools/include/uapi/linux/bpf.h' differs fr=
om latest version at 'include/uapi/linux/bpf.h'
  CC      /home/teawater/kernel/linux-ebpf/tools/testing/selftests/bpf/to=
ols/build/libbpf/sharedobjs/libbpf.o

Best,
Hui

> ---
>  include/linux/memcontrol.h | 4 ++--
>  mm/memcontrol.c | 2 --
>  2 files changed, 2 insertions(+), 4 deletions(-)
>=20
>=20diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 229ac9835adb..f3b8c71870d8 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -833,9 +833,9 @@ static inline unsigned long mem_cgroup_ino(struct m=
em_cgroup *memcg)
>  {
>  return memcg ? cgroup_ino(memcg->css.cgroup) : 0;
>=20=20}
