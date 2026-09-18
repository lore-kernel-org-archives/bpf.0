Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3621E30D3F1;
	Fri, 18 Sep 2026 08:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789721037; cv=none; b=LO02gTE8sz4aqqtWEMi2oqtWMj3P++RY2Aa9m18RL0GnaCXuSZJV3hcJ3T7T1suep5sr3CxftFc3kNTjRUO6JqE6TNilMHV2Sz+fBHefQtPzhsIeOMWkyMXRhtwyneeLeCqaXCy6IFf1C/vd/yYnPdSgg2UcRxxT6296yxdww/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789721037; c=relaxed/simple;
	bh=ydMCf8UeCKVTabrS2pzlAs+ixDGgnsY1Oj1eP8jCuVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZoiYjqiUCVQPdsl0hfEzPYUw0v6bKTRnW26+uuokea9JpFjEEm9w/BAheBoIQUANeTs4W7hpjfwElPOOnPyYUNqgDJHKeAwSqQkl9qFPsNRdx6G6Pq+dhNjzYPz9pdw449nUeVDn4/kUXMaiteOHkxrUp2ey8Ldjfeql5kSqUJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l2w0L1Ea; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2w0L1Ea"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55F911F000FF;
	Fri, 18 Sep 2026 08:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789721036;
	bh=p7yW5RQQpzce61fxOhF/6V3uC/yEcVaMlk0RaYCfGUI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=l2w0L1EaCBM+Y6IyCZk0McWa1cU1klEYgp9+DejVz4E8TGx02JDSLpInw1Rtsb+G7
	 8PzZLnXoeZ1ZKX1GSfunBrrR+/z8odss8QPpEz4cpU9rlESsLV234fcMqZDegSNWuj
	 uGr2+GJQb4oi2TrlLgFQt0zoqFciEC163dJHSDeWkIDhA/Mo1YwLQXhbnNDGz2gcCy
	 zYRknFQZHNSJGB3PaPJjIWbusT2TU3fxBiuaSfwJexAxwfe6ijtoZjIEgp9GCpWQP4
	 hcEjFcBzGXFVTJJSaowXo8RcXhHlcgtV+f5syvI5rj7UZq2QT9NqYMuOZHKsz7n56l
	 2Hg22LcJULBVA==
Message-ID: <aa563c53-2d79-483a-999e-159006d59026@kernel.org>
Date: Fri, 18 Sep 2026 09:43:52 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 1/3] bpftool: Skip non-autoload programs when
 generating light skeletons
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Shuah Khan <shuah@kernel.org>,
 KP Singh <kpsingh@kernel.org>, Leon Hwang <leon.hwang@linux.dev>,
 Emil Tsalapatis <emil@etsalapatis.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260918040919.3402577-1-tweek@google.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20260918040919.3402577-1-tweek@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2026-09-18 14:09 UTC+1000 ~ Thiébaud Weksteen <tweek@google.com>
> When generating a light skeleton (bpftool gen skeleton -L),
> bpf_object__load() skips loading programs marked as non-autoload (e.g.
> SEC("?...")), so the generated loader program only records and populates
> file descriptors for autoloaded programs.
> 
> Previously, bpftool emitted struct bpf_prog_desc fields, link fields,
> and attach/detach/destroy functions for all programs in the BPF object,
> causing the loader program to store subsequent program FDs into
> incorrect skeleton struct fields when non-autoload programs were
> present.
> 
> Furthermore, bpf_object__load() can update a program's autoload status
> during preparation (e.g. for struct_ops programs when resolving kernel
> BTF members or adjusting autoload based on map autocreate settings).
> Move bpf_object__gen_loader() and bpf_object__load() out of gen_trace()
> into do_skeleton() before counting programs and emitting struct fields so
> that struct field declarations and attach/detach/destroy functions all
> observe the final post-load autoload state.
> 
> Skip programs with !bpf_program__autoload(prog) when counting programs
> and generating progs/links struct fields as well as attach, detach, and
> destroy functions for light skeletons.
> 
> Fixes: d510296d331a ("bpftool: Use syscall/loader program in "prog load" and "gen skeleton" command.")
> Signed-off-by: Thiébaud Weksteen <tweek@google.com>


Reviewed-by: Quentin Monnet <qmo@kernel.org>

Thanks!
