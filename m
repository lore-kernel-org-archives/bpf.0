Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC804CEE7E;
	Thu, 17 Sep 2026 12:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789646647; cv=none; b=e9xymdTTNdq++xJsNiFrj2lIJ02/zm5ASgBcUAuEt7/C692BYRY9/4cUur8rrIyoWWMmlh028edNsoFIrm8vfow/Vc2dSg2xcNAbFhnD8aWCrd7Wb/2S616s9YY5pTnrfShMAIaDQePhCdcRlCpU6I5O6MzcK9ShBPT65rxLqw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789646647; c=relaxed/simple;
	bh=/L3hhoTbNJz+VzjwfoPr00mVHDS6Ay2SKgZ4ODlBzEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f1RqCQuWPN6e4h8JBLl/ucw/uZM7e28hv+bUDl+EI11i84e3wJOy+DduB+dSdYXw9Jf7S1r8VGYSybyGUudJA/ZaclgkKcPW0qO+OPGG4YbutDGMguIPsZnnWUtBfv8CtiD4zANzsYA++7Z+Im31q2B9VtUe1GCt+L7k8Gunyx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jklPrq02; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jklPrq02"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3B2B1F000FF;
	Thu, 17 Sep 2026 12:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789646631;
	bh=6MSPGL+sKgOTsno6EvM4rjUx7pDY2PlxTrAgOGCm3XA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=jklPrq026R368DpShveUnqYIaJx2zkPuyBRePG9Li+WsC5PfXkb4nHP76IjbzOkWj
	 FwdNx1ksGDHGF8720s211p/r27Bh9CR+c0vB3vnwbWgMdwQ7jxWtjtpWVVk0Eps8EG
	 dXBjb9XRjCx0q0LjYHCakPPsMnYftuHXQxn5WJI+gjxDgC/1FCDm7IJV1BO/CFIoqG
	 nuNPEWsKa/C5qldgK4Pz6HkDyfqC8A5HxUdUqGg6Ous2XbEzh4mapnX1nVC+YjGXX7
	 GIbcJFScZdpELyJem1RrXatTtXOLu2HIqMiCrMIJKnt23p99e6Qjz+36mrni0VfGlV
	 lWQ4t4WuacW9g==
Message-ID: <27db90ca-dd4f-48a5-896c-cf0b1052101a@kernel.org>
Date: Thu, 17 Sep 2026 13:03:48 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 2/3] bpftool: Compute light skeleton ctx.sz
 without relying on links
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
References: <20260909042433.1775591-1-tweek@google.com>
 <20260909042433.1775591-2-tweek@google.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20260909042433.1775591-2-tweek@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 09/09/2026 05:24, Thiébaud Weksteen wrote:
> When generating a light skeleton, gen_trace() unconditionally sets
> skel->ctx.sz using (char *)&skel->links - (char *)skel. However, if a
> BPF object has no programs and no struct_ops maps (prog_cnt +
> attach_map_cnt == 0), do_skeleton() omits the links struct, causing the
> generated skeleton header to fail compilation.
> 
> Compute skel->ctx.sz from the end of progs (if prog_cnt > 0), maps (if
> map_cnt > 0), or ctx instead of relying on skel->links. Also remove the
> unused opts.data_sz argument passed to codegen().
> 
> Fixes: d510296d331a ("bpftool: Use syscall/loader program in "prog load" and "gen skeleton" command.")
> Signed-off-by: Thiébaud Weksteen <tweek@google.com>


Acked-by: Quentin Monnet <qmo@kernel.org>

Thank you
