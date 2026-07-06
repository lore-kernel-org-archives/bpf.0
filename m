Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB12346E59
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 11:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783337979; cv=none; b=fQKxt8rkgAkGq+rxabTBFeVGOcZZ1VvvbmjJ7MwiREvyNubifAgVlrXcwIaVEdMy1Yidi3W8HMNHIHqEzz3XMDBuJkoOS2W1ZP/1PK9if0wUDqsFjcITupFEb+hSkDqUFvgpKEb4Q/0FhiXpB1K0ZytAQGqWpsa7T0+KD/RV47s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783337979; c=relaxed/simple;
	bh=Wjumf1wJOL2LQ1l4O1G0CwcPYWAYntscI+138+QgHEI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NDDVte46rmDRzUx7DjSRVR2lKtP6oRY8ZgtTtdwoYaxUSKHuNlqLmNgS+42ouXRZ99W3dXU71KKe6PxVZOvwzMFxsCy4KzO+iU+yhJsIireaN6w3juc95G06GyR26ryt5f5tNeL00noKp2MEhcmUjwanFBgXY1+c39nbErut6cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NWdJ234+; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NWdJ234+"
Message-ID: <dd75b7afbe2b5507ac818df14dd44aff32db1e18.camel@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783337966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wjumf1wJOL2LQ1l4O1G0CwcPYWAYntscI+138+QgHEI=;
	b=NWdJ234+B87Yx1NHHmJto1s5psaBbb8vITOAD5zKV8kSJcjMZ5JjwbpSxOGKcW2zNJfpBI
	aA/nbSTexc6HGfYigPHvZvchszxupeSUl+1uLBaqnatmE7E43VDEf6Wf7OhdgX2scgMEun
	DpDoj/WpZld0i7Mn6qlDwSc9SvaZhQs=
Subject: Re: [PATCH bpf-next v8 1/2] bpf: Introduce jit_required flag and
 remove bpf_prog_has_kfunc_call()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: KaFai Wan <kafai.wan@linux.dev>
To: Tiezhu Yang <yangtiezhu@loongson.cn>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,  Kumar Kartikeya
 Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song
 Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa
 <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, loongarch@lists.linux.dev, Leon Hwang
	 <leon.hwang@linux.dev>, Puranjay Mohan <puranjay@kernel.org>, 
 =?ISO-8859-1?Q?Bj=F6rn_T=F6pel?=
	 <bjorn@kernel.org>
Date: Mon, 06 Jul 2026 19:39:12 +0800
In-Reply-To: <20260706040006.10331-2-yangtiezhu@loongson.cn>
References: <20260706040006.10331-1-yangtiezhu@loongson.cn>
	 <20260706040006.10331-2-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT

On Mon, 2026-07-06 at 12:00 +0800, Tiezhu Yang wrote:
> Introduce a 'jit_required' bitfield flag in struct bpf_prog. This bit
> tracks whether a BPF program strictly requires the JIT compiler to run,
> preventing dangerous runtime fallback to the interpreter for features
> not implemented there.
>=20
> Set the flag 'jit_required' to 1 at the entry of bpf_add_kfunc_call()
> right after the kfunc_tab allocation succeeds. This cleanly marks the
> lifecycle of any program attempting to utilize kernel functions.
>=20
> Furthermore, completely remove the bpf_prog_has_kfunc_call() helper,
> as its logic is now unified under the 'jit_required' flag.
>=20
> In bpf_fixup_call_args(), check with 'prog->jit_required' rather than
> bpf_prog_has_kfunc_call(), and generalize the error message to generic
> BPF JIT availability.
>=20
> In __bpf_prog_select_runtime(), check with 'fp->jit_required' rather
> than bpf_prog_has_kfunc_call() to unify the logic.
>=20

If you have a new version, I think we=C2=A0could simplify the description o=
f the code details a bit.

The code is fine by me, others might have comments.

> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Suggested-by: KaFai Wan <kafai.wan@linux.dev>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---

--=20
Thanks,
KaFai
