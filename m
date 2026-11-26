Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795707250;
	b=hm3ZrubW50leyqk0UKOg9lieyKMsmAbEkfkbC55allfmkdDkq7VAjwT8UfTmJAaXdhNj
	 cgm8T0amCLsGd+Cd3xvCJRt3Pu3RAySNAThECjuJr7LkZQlcdHC7gYtRGsrFDJudoBjJu
	 i+tX8yuNRzdUZOgNY2KzOEFr9nxiVkzyFYyIjX157Hxh3IbSKE/TyRN2nilf8/kTKkkU6
	 4KFpvUbe3nCUL2Wnq3x9xiNXcABwuaMD9mY7UTgrznucQCMVkCHbFRwTt7voWczboVmez
	 oRgu7DAwYphIs2D7Y2ngHe0viqxQB4i2/s8qNYZYrOhtkrm7+oIKiSqmCXrw8abNWWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795707250;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=2CsfoafM/EZFVEIb23+biOrzSZWJnXuLqX+PWuffNgk=;
	b=z5z7n0RHreanQ/bwhnBIP/4WvVoSpdhaIawK8kTMTv8+oPkp6mQ3n9s3eqrfDkcHu4kD
	 sVcDpId8CtykSuWU5ahm6Qs/LLHf+H3V+frHhpGRAw7Rh6jEauy8jr2XwUU+AngYKtTq+
	 OL3cgJ2yQ+Uf5YDEMCuXWx+xa5ShgAM6PAorl0BxHUUWmqpFiS5pfClF4aqm+1lscyhZK
	 8o6/bFXoFTXdMzGL7bQ0NlNiue+ma8v8SjkgaJa1GEWqGx3SZVgP5+gmHvhEe6rf0NL04
	 EmwEblR/FclhSOHK5qLyJ5pAvg6E7Msp29TvuaIE2WOWDbewdD0/q6QSwGdmuZ6gOAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FOEuXgmZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5393C606A31C;
	Thu, 26 Nov 2026 15:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FOEuXgmZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B1E91F000C0;
	Thu, 26 Nov 2026 15:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795707249;
	bh=2CsfoafM/EZFVEIb23+biOrzSZWJnXuLqX+PWuffNgk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=FOEuXgmZKCGEw18JN2yb9ZL1JmuBxzFHyXhlrcLP6dvvNxW8SKZIOtzzC0reWpZpN
	 FtiEh6XJ4xZ/sbKRPIQSNdM2PWfAJQyBhm7uVTf6hLa1fGMKzB9+UpMwJHiqh1WN0g
	 QKC4ONTthTIk2bmCO6CbzN73PyKuvuhfDEF00Z1MwnjS+F/o0sNornq4Xp4+Rkrn1f
	 n7TF8iEvjHPaoSO7oGo9bgWEZEEpuw9L/rdHlEWp0KQrJ12bHxW8uAio60+me+1XUK
	 cgIWIgKNpqXS9zsftp5G8isGURzhp5eueoW2cIjbGgChcuLv3Ab0tyBF9DidCDDpc1
	 2RvZxrKinrwtQ==
Message-ID: <8debe18f-e8f8-45d2-9c25-533fe1f15755@kernel.org>
Date: Thu, 26 Nov 2026 15:34:06 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf 2/3] bpftool: Reject non-autoload programs for light
 skeletons
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Shuah Khan <shuah@kernel.org>,
 Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Sid Nayyar <sidnayyar@google.com>
References: <20261125004911.3937193-1-tweek@google.com>
 <20261125004911.3937193-3-tweek@google.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20261125004911.3937193-3-tweek@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2026-11-25 11:49 UTC+1100 ~ Thiébaud Weksteen <tweek@google.com>
> When generating a light skeleton (bpftool gen skeleton -L), there is no
> libbpf runtime object or bpf_program__set_autoload() API available to
> enable or disable program autoloading. If a BPF program in the object
> has autoload disabled (e.g. via SEC("?...")), bpf_object__load()
> silently skips loading it, while bpftool still emits struct
> bpf_prog_desc fields and attach/detach/destroy helpers for all programs.
> As a result, the loader program writes subsequent program FDs into
> preceding skeleton struct fields and leaves trailing prog_fd fields
> unpopulated (0).
> 
> Move bpf_object__gen_loader() and bpf_object__load() out of gen_trace()
> into do_skeleton() before validating programs and emitting skeleton
> struct definitions, so that any autoload state adjustments performed
> during bpf_object__load() (e.g. for struct_ops programs) are observed
> and no partial header is emitted on error. Explicitly reject any
> non-autoload program when use_loader is true with an error message, and
> document this restriction in bpftool-gen.rst.
> 
> Fixes: d510296d331a ("bpftool: Use syscall/loader program in "prog load" and "gen skeleton" command.")
> Signed-off-by: Thiébaud Weksteen <tweek@google.com>

Acked-by: Quentin Monnet <qmo@kernel.org>

Thank you
