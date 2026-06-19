Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3029340D569;
	Fri, 19 Jun 2026 00:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781828789; cv=none; b=IooofmAmmaVlgKFShj/fTDoqSLD9kgBZb6eH1grWrSmS6UeJL803OVIT128ZJbOLYNAbRhky+tr9xKxCPGDBkAdT0RQ0Nj2I8l7dRLrKgXbqIrZDOU2bbrS4pk5/yiIpYzDiqMMGW/JHnnKr54OcFopKjyNX6iwxAZpoziCXVdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781828789; c=relaxed/simple;
	bh=a1ubikN2O95ZQU4qv6mTMkmGe/uAEX2Huc+nNp8vDnk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 Content-Type; b=ZDXtdU+7c0KaeBT3e27vbL828XuvGzuDzNaUvNYIFxyb0SMkLuMPeq+e+8LxjW7Nanv/cYBQnDAiv+z8GkuaofAlW/BNfpZETQsHClijWMJt9fA0iRotDBb/gqoby8o8su3taXAQMptGGNs1C8fsAu49VWT0ISzSnqLHiXhOboQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fyga2iUV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fyga2iUV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF4931F000E9;
	Fri, 19 Jun 2026 00:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781828788;
	bh=a1ubikN2O95ZQU4qv6mTMkmGe/uAEX2Huc+nNp8vDnk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Fyga2iUVc/71SEGDm+0ggpMRLBFh5uu3S3RS/b4aaqZkgRiMVyIGyfNvZTDqPmhAD
	 Zva8gmOgKBqqLHsfVOwNyXiVMNej2r9xVGduADCkYfb1tPnJjt3xnvSV0VkBCNkbMg
	 sM1Mzl6g2tq9fJRq8KHtUJ5t44L92w65RkUWfkVBtNfc8vtnLqU/HaRU+gWvl5dgnC
	 ztoocgofACC5chCZl7heENIA+/N1B3+7s3vRw3wCnSUJv0bVnldCrP9CnDPN5tQ2sv
	 7bqJ0gYJjYL8ezddPp40CYwEC6tJHKbiyDC7OpK2jD41eKq44AkE+dnjMIyNXa6FqK
	 V+KaN3VutDElw==
Date: Thu, 18 Jun 2026 20:26:03 -0400
Message-ID: <9969d75b489115098169880814d4f58c@kernel.org>
From: Tamir Duberstein <tamird@kernel.org>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 Jiri Olsa <jolsa@kernel.org>,
 Shuah Khan <shuah@kernel.org>,
 Andrea Righi <arighi@nvidia.com>,
 Xu Kuohai <xukuohai@huawei.com>,
 bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org,
 Andrew Werner <awerner32@gmail.com>,
 Zvi Effron <zeffron@riotgames.com>,
 Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCH bpf 6/6] libbpf: ringbuf: Reject overwrite callback use
In-Reply-To: <DJBZ6ML455FF.15NG4FYCAX9DE@etsalapatis.com>
References: <20260613-bpf-ringbuf-fixes-v1-0-e623481cb724@kernel.org>
 <20260613-bpf-ringbuf-fixes-v1-6-e623481cb724@kernel.org>
 <DJBZ6ML455FF.15NG4FYCAX9DE@etsalapatis.com>
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Thu, Jun 18, 2026 at 02:52:58AM -0400, Emil Tsalapatis wrote:
[...]
> Nit; unlikely(r->overwrite)?
>
> The check makes sense, we can add it whether we keep
> ringbuf_validate() or not.

Done in v2.
