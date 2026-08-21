Received: from mta1.migadu.com (out-159.mta1.migadu.com [95.215.58.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DFA48C402
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 13:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787319726; cv=none; b=FgcIR1vJy2dpWQjaHO72zuO2r3gTq4MdZasgrXqUwxSxf3lUjyuFYKRLdcKNspXJ0+3oFdc+9W1ea1ifxF7JDMWtixiAVnbCW2DLG7gjJVb8bVGvkdbfyIcoPozYJgf64LwJLEH7viQU4GY/c9Dujd+kxzPar9xezILJCziWPhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787319726; c=relaxed/simple;
	bh=xoHK9+X6f4afTg10I65h11RX5Yl8L7R5TuqKmK/7bIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fnsOxxSDn3+BvEcK6zEgA6EdmnMXLuQVNKXNoorDSdUYxxAB9Km0s+T1Y68X3lfRttVFmNGnTNAl7XFx2PlXPbMtREwbh86kR0lo9Kmh+Dm15iuUvMTtLgjIFscVbr9ovrQiZgVXehmnzDMVj4lrMfisMGGlMjq/F8+xLbgeulk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DxykamQ+; arc=none smtp.client-ip=95.215.58.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DxykamQ+"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=xoHK9+X6f4afTg10I65h11RX5Yl8L7R5TuqKmK/7bIY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787319718; v=1; x=1787924518;
 b=DxykamQ+hnui9EXFCEsAxjUY1tZ+iCVayqvRiMv3jOMfjUeiJ1VDGYkbtokOMaKyNGfmHQMj
 82ZGxMroXliEMCMlWplVhfiiHh42HlMsY0HTxq0fSQjiRnk4W+BxJ0IyzX5p5x1AF3FgR0po3Mb
 YwN4zEf3LimMRkph5Szxtqsw=
X-Envelope-To: bpf@vger.kernel.org
Received: from [172.20.10.7] (117.20.154.125)
	by smtp.migadu.com with ESMTPS id e6011bafc4258f8b;
	Fri, 21 Aug 2026 13:41:48 +0000
X-Mizu-Trace-ID: e6011bafc4258f8b
X-Migadu-Flow: FLOW_OUT
Message-ID: <1ab678ef-6349-4374-9ebf-22f857211ca7@linux.dev>
Date: Fri, 21 Aug 2026 21:41:29 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3] bpf: Fix stack out-of-bounds write in cgroup
 link update
To: Sanghyun Park <sanghyun.park.cnu@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: John Fastabend <john.fastabend@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Stanislav Fomichev
 <sdf@fomichev.me>, Pu Lehui <pulehui@huawei.com>,
 linux-kernel@vger.kernel.org
References: <20260821084726.3769957-2-sanghyun.park.cnu@gmail.com>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260821084726.3769957-2-sanghyun.park.cnu@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/8/21 16:47, Sanghyun Park wrote:
[...]
>  
> @@ -5968,6 +5975,22 @@ static int link_update(union bpf_attr *attr)
>  		goto out_put_progs;
>  	}
>  
> +	if (link->type == BPF_LINK_TYPE_CGROUP) {

Furthermore, I think this link type check can be dropped. Then,
link_update() will keep the same bpf_prog_attach_check_attach_type()
with link_create().

WDYT?

Thanks,
Leon

> +		atype = link->attach_type;
> +		/*
> +		 * BPF_LSM_MAC and BPF_LSM_CGROUP share BPF_PROG_TYPE_LSM, so
> +		 * the helper's default prog-type check cannot distinguish them.
> +		 */
> +		if (new_prog->type == BPF_PROG_TYPE_LSM &&
> +		    new_prog->expected_attach_type != atype)
> +			ret = -EINVAL;
> +		else
> +			ret = bpf_prog_attach_check_attach_type(new_prog,
> +								atype);
> +		if (ret)
> +			goto out_put_progs;
> +	}
> +
>  	if (link->ops->update_prog)
>  		ret = link->ops->update_prog(link, new_prog, old_prog);
>  	else

