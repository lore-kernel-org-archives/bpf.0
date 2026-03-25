Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A652D5950;
	Wed, 25 Mar 2026 04:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774411834; cv=none; b=WyYRtFkG/cgm7wC+CHOtzi+GwPTcLHR0Nkm0PKnV9lEp3HuPdgZHFsC62cyQxBBloPOjuaQ9xmcLGT8sGQxEQaSt08jWeaiOTX25wO3srMRBcxzBlQ0Y63CSOmwZ+4DjIITeAx4ccKlCm61B8lL1ywhBtr3NiNvYMqaZaW6La8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774411834; c=relaxed/simple;
	bh=Io6dHWWlxQDn5v2v/88XmGH1oU328xK2X6byiSoqf/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hOvmsgfCxDxtAc6pRPG/lTHB4VFs3gxVCJ40lJofsxT6ySPfaiVIOoVEK5hefN9QTf1KE1BO9uqrmxAd9LlN4hdXWlN8+mYVaK4CCCswQ7Lr1qyFNsV2hY8bCsGsNdsx2d/N4Jp9qJyN3l0YB5ucpZA/i6iCauTG7+qymyjkXO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLzrExNf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLzrExNf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4112C4CEF7;
	Wed, 25 Mar 2026 04:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774411833;
	bh=Io6dHWWlxQDn5v2v/88XmGH1oU328xK2X6byiSoqf/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eLzrExNflqv0CDBucBia98o/NJjdE6FmynWS/M8sN2NySunqgBoezH3/lCIODI0mu
	 isi0vV8/MaoGloIuY6xslZUtJSjKKI84bAfaUsRA6iodE2cQxUd6zDhuZ+Y2Nt1ksn
	 SkATdFrvN4p5eULTTpQxcCpWX3o4Ngqb9+iuJB02cSmZw6/ajbXlH0P+Ha6bsEUHOt
	 /cOKIycVuCuc8fsKXZ7tuMPBUpyKuq6kj2uvJ92SMWpEZP5Bt9g6D2TbMvS2QYPE1h
	 xpiYUoHUvPjhFwEKclpLS1+tQukdZF1vXToiW/sWMev0GrlazN5NUBQ2bqMFKQ5iW3
	 l6nE4nzuAMQ6g==
Date: Tue, 24 Mar 2026 21:10:33 -0700
From: Kees Cook <kees@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] libbpf: Replace strncpy() with strnlen()+memcpy() in
 skel_map_create()
Message-ID: <202603242109.171584E8@keescook>
References: <20260324040535.work.851-kees@kernel.org>
 <202603232224.C1555BF@keescook>
 <CAADnVQLhWURvQ=gBYQvuEa3pTxabYQYhrPm9QG0gbxL9ee=vng@mail.gmail.com>
 <D53376BA-4772-486B-A18A-6858C1732723@kernel.org>
 <CAADnVQLA3K6v_+_7-+BDVEeZ2N=6229FL6Ko=3ywDWsPVOPLcg@mail.gmail.com>
 <202603240919.D248D71B48@keescook>
 <CAADnVQK+hMnUkv5TfOGfiVR+nf59bBX+zaHOvcp5zSZTpdJB_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQK+hMnUkv5TfOGfiVR+nf59bBX+zaHOvcp5zSZTpdJB_Q@mail.gmail.com>

On Tue, Mar 24, 2026 at 09:31:09AM -0700, Alexei Starovoitov wrote:
> And please keep ignoring it.
> It's not broken. Don't fix it.

Okay. I'm confused, though: what's your plan for when strncpy is removed
from the kernel?

-- 
Kees Cook
