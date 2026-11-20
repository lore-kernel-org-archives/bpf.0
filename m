Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795170180;
	b=5kaeaSS62aAoLGXma+D5CuebLCn5aigEGiQ3pcZel+6WFzFc+r4MEV5rz1wzE8e2E0Rp
	 OoWil3n/es3/ljJ0c4FDXC22YSwlJb9Tzl65xqhDVi7eLSHxTMnlXLe6AaZzYqWHTUH77
	 G8/lSkVJ2EKI5Y/3qfjVelNPSe/flXpxx0LWL+TU/2q8Rr87MXuAt5HnLzA3HYDfz/HTW
	 wjMzRHU9JVjBt1FS1mvVkMC/5UdZ2Fvc8802UD5BmokkJ0sYf0hwLwb05cN6V4UCUnqOa
	 FvZ+xkrrMdxKSZ0tWWogIQfxoAKv5d2g4YL1evE52hgR6sRBtW6xaPy8TuIPYz0nYTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795170180;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=AfJVh7uFWkG93CcIU6uXtcUN7858JzhFpn/OacUyBUs=;
	b=JCiApX7FRv5JfJEuCNfPGzgvvNaSLaaGkQzB8YIsHzCKguPOJPyMkpRPRRhth2+S/rAb
	 yFRKIBo0zHzUPeYlDgV6HT2swDdI4+SAoY5Kf6+56uYgGtzRI96eEKDXkXFEdi73FmSxs
	 PdAO5yn9JBtmGW7AHc7Tpgs1YeOn3Q+tpd7vCvILJiGBoW/r5AoEOeVVr43hw2DlRYbHu
	 45H+mNimCOS86ydT0HzJUWb709Fx13n5SB+CnHNXeTx34LtcgSg86QIv83Goj5XgDqleA
	 eFPYlguXSuf1x8vKohHQt7Mb5lfxiI+c/uS1q85Op/LXEgwlE2b0yqD4+b4rtW1GvLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TOdGOWDO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7206D606A320;
	Fri, 20 Nov 2026 10:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TOdGOWDO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88A491F000D2;
	Fri, 20 Nov 2026 10:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795170180;
	bh=AfJVh7uFWkG93CcIU6uXtcUN7858JzhFpn/OacUyBUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TOdGOWDOE4Q92JqZpqx1GjG7P/VGi6q7lu5iUCneklDKerF+BvgSp3V+hvXV3N6os
	 H+cURRSLyDj5yTNEiU6aO3tuCgW6cnnCwDxCAcIXfGW2ZxAH0Op0RJ7HclI/Vgd7Np
	 HSJMJ00npcxaTVlSmNHRpl+6DpyMMc3vK/ovrqQaf1tivc6QU0h4Gtkhke5r1nCwif
	 jRaHkRM5T13INlz24gEfe9okl2spy+DYQ1SedfUt/ySHtyRXfGSYLd59aF93aRz1uu
	 D2s+3h+1mi0C0WqpCIFezw0V3ZCEXg/SUOhophL3cuCueGd9MXFceCgFJnzYBFVTTI
	 +v575icriio8Q==
Date: Fri, 20 Nov 2026 11:22:49 +0100
From: Christian Brauner <brauner@kernel.org>
To: Samuel Wu <wusamuel@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Petr Mladek <pmladek@suse.com>, David Laight <david.laight.linux@gmail.com>, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-modules@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH bpf-next v3 1/9] Documentation: ioctl-number: Add
 PROCFS_IOCTL_MAGIC range 0x10-0x11
Message-ID: <20261120-antitoxisch-flott-sense-8c2a09fc9679@brauner>
References: <20261113221248.3535369-11-wusamuel@google.com>
 <20261113221248.3535369-12-wusamuel@google.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261113221248.3535369-12-wusamuel@google.com>

On Fri, Nov 13, 2026 at 02:12:46PM -0800, Samuel Wu wrote:
> +'f'   10-11  linux/fs.h                                                conflict! procfs ioctls (PROCFS_IOCTL_MAGIC)

Those are PAGEMAP_SCAN (16) and PROCMAP_QUERY (17) which are already
in the tree. The two ioctls this series adds are 48 and 49, i.e.,
'f' 30-31, and they aren't registered here at all. Please add them as
well.
