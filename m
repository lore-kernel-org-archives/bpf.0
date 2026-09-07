Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099D227057D;
	Mon,  7 Sep 2026 15:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788794651; cv=none; b=qAb7vzDcrJKHDm9NiKfbHZxMseipEH7rvaP+ItiuCe5hKS+ky3SsVSsAuEAJqx81jlkaOc7j0cdPFoydVqJ0TLN116PosGuWsXmdg3AAXslTjgV1WfLmM4VzKZor0btx7Lk0Rd44sBen4mVWAlTiDfz2otVl52iM3w/YbhIQImU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788794651; c=relaxed/simple;
	bh=GTuBLuN4JOqWdZd1Mu3f0IP0dpVMTxxsE0i4r7IPbms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LhrimGEL7yzoEVALjTLrOmJxch03r47sEVlyYB9jIJHZbrm2njx0PRxGzzD5Unsa2c7kk45NfhK/Cz/CeWvFEnmnfOv0UDuET7EzQsm/PEnd5hz8itd0X1whMUPEICUTYwzNygc7CngM2xt+bsl1+toLIfp8P2UsSBF2o9r/1X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WGLDhRNt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WGLDhRNt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C41A51F00A3A;
	Mon,  7 Sep 2026 15:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788794649;
	bh=XJq6pvnPJHRY0KLfPMgxtLcYaufXaCJJ6tr4Hi7QX3g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=WGLDhRNt4nRE4aE9ezf3Tni8/D/RqTrv1a6R29B8mOCPBobKtLb9zo5/lK9jOjLby
	 Mt4b+OTtv8ryjM1qaIQNB89XPtXya1ta6ZulDgDK7CZJop1+wfVILgwIO3MqgD0ub6
	 woXVtkapsHft7cjq4J3BuccCWv8KHf7zjuA5/xTBYuXfEE+WJOA8yR4/nvlQU3UiEM
	 192hBNaTqr0SEDWxCJp1XYE5GT46/0RvbwyqZe9w4gnxhfWbzvxx6FliXBykjqnrn7
	 FdefVRyfxMD1toYikoM7IQ+k7OLpz+ysg4cSsUclLwo4MsyZ1HbMyg2bd31iW24wEz
	 2kqUMw1lREm2w==
Message-ID: <4468d220-9d7f-47d0-8e5c-c01070ab2d47@kernel.org>
Date: Mon, 7 Sep 2026 16:24:05 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/2] bpftool: Reject non-autoload programs for
 light skeletons
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Shuah Khan <shuah@kernel.org>,
 Leon Hwang <leon.hwang@linux.dev>, Emil Tsalapatis <emil@etsalapatis.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Sid Nayyar <sidnayyar@google.com>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260904031912.2133476-1-tweek@google.com>
 <20260904031912.2133476-2-tweek@google.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20260904031912.2133476-2-tweek@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 04/09/2026 04:19, Thiébaud Weksteen wrote:
> When generating a light skeleton (bpftool gen skeleton -L), there is no
> libbpf runtime object or bpf_program__set_autoload() API available to
> enable/disable the autoloading of programs. If a BPF program in the
> object has autoload disabled (e.g. via SEC("?...")), bpf_object__load()
> silently skips loading it. bpftool still generates struct bpf_prog_desc
> fields and attach functions in the light skeleton header, leaving
> skel->progs.<name>.prog_fd uninitialized (0).
> 
> Explicitly reject non-autoloaded programs when use_loader is true with
> an error message, preventing the generation of broken light skeleton
> headers.
> 
> Signed-off-by: Thiébaud Weksteen <tweek@google.com>
> ---
>  tools/bpf/bpftool/gen.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> index a50540ef6521..1583150241c8 100644
> --- a/tools/bpf/bpftool/gen.c
> +++ b/tools/bpf/bpftool/gen.c
> @@ -1340,6 +1340,12 @@ static int do_skeleton(int argc, char **argv)
>  	}
>  	bpf_object__for_each_program(prog, obj) {
>  		prog_cnt++;
> +
> +		if (use_loader && !bpf_program__autoload(prog)) {
> +			p_err("program '%s' is marked as non-autoload, which is not supported for light skeletons",
> +			      bpf_program__name(prog));
> +			return -1;


Sashiko is correct, at this stage of the function, rather than returning
directly, you'd need to "goto out".


> +		}


Thank you. Maybe consider adding a word about autoload/non-autoload in
"bpftool gen" man page? My concern is that users who are not familiar
with the notion will struggle to understand the error message.

Quentin
