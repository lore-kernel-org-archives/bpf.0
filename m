Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1623E569F33
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 17:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790098036; cv=none; b=iEXyJRF5utqibRaEPj1h9CQBSrOAW30dn2R+p6B+gw18Q9w0KDlgeau/hfK4/yJ8adZNInzoFWD/eZcJNLepB9YqTmBRP3wQcHuH9epCFUuRRusga3cu13VR6Y9al+Y695ePt5LeleCYaOzpXdEnHSyLXz8LZ/nXVJnANKGfK2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790098036; c=relaxed/simple;
	bh=U+a0vaSp6XnkT+1HezgmmCMVvOvq5bpzmIqK3bz49e8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s2PWZIpmRTkZLGTELU3MdzRb7zlxt2Yycgud4Z3/h9yMVIVaSkbSEK5R500++2delpGPX9BoZqHFnP7BeQoB1mc3revetn8l4qUk86mkUD2T1SyWM3htqjdQvCl5X/z8GEgd4gPNjcGS7h9DSCllW7QlhWFwveg3s1ipOIl7ghM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bw+168Rv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bw+168Rv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F9851F000FF;
	Tue, 22 Sep 2026 17:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790098032;
	bh=IcQ4Y710VvhojmBGNyDtUut8erzumNxb+hocC20H8D8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bw+168RvOcEfish/XSdTKjnYXwr4cewglgIFJUd2Gr1j7IwixnPcZ27xP4hZonHQk
	 0NlBZOi/BFaxhrCJF/AtP4s6JVmRzh9WJrLmfwqqvPlh2wYpX6dAZ8jXEVG43wn5R4
	 VspwXf6Znwx0Z8YYvp9i0ReGnnwRzSJ0o5mDZeAEGpfvt5+67THZLVpT7dYRUVx8nx
	 hpWWOH2DaJP4q9LRmZg74I8QIwdb4M5I+qD3+FE9uV5JLyJQ0tBZSEeFgUxDsSfObc
	 NBK1FY3LwgBD5xJwXPXhW4KNdfDHjUE/1aSwpjqMI5UBUeclAZaYVv3r5SbXB1jdMT
	 o4OQKq/RI/t8w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2 01/11] bpf: Fix bounds check for skb-backed
 dynptrs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emil Tsalapatis" <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260922172028.6269-2-emil@etsalapatis.com>
References: <20260922172028.6269-1-emil@etsalapatis.com>
 <20260922172028.6269-2-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 17:27:11 +0000
Message-Id: <20260922172712.0F9851F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: commit message claims u64 arithmetic but uses 32-bit unsign=
ed
--

commit 5861693b35f3cce5042bdc052c43183ecc29425f
Author: Emil Tsalapatis <emil@etsalapatis.com>

bpf: Fix bounds check for skb-backed dynptrs

This commit fixes an underflow vulnerability in the bounds check for
skb-backed dynptrs within skb_pointer_if_linear(). It prevents spurious
passes by converting offsets and lengths to unsigned integers before
performing bounds comparisons.

> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 421f6fc454511..c8e21903074c3 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -4372,7 +4372,10 @@ skb_header_pointer_careful(const struct sk_buff *s=
kb, int offset,
>  static inline void * __must_check
>  skb_pointer_if_linear(const struct sk_buff *skb, int offset, int len)
>  {
> -	if (likely(skb_headlen(skb) - offset >=3D len))
> +	unsigned int uoffset =3D (unsigned int)offset;
> +
> +	if (likely(uoffset <=3D skb_headlen(skb) &&
> +		   (unsigned int)len <=3D skb_headlen(skb) - uoffset))

[Severity: Medium]
The commit message explicitly states "Use u64 arithmetic to also prevent
overflow when calculating (skb_headlen(skb) - off)", but this implementation
strictly uses 32-bit unsigned arithmetic.

Since the 32-bit unsigned math appears to correctly prevent the underflow a=
nd
overflow in this context, is the commit message's reference to u64 arithmet=
ic
inaccurate? Does the commit message need to be updated to match the
unsigned int implementation here?

>  		return skb->data + offset;
>  	return NULL;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922172028.6269=
-1-emil@etsalapatis.com?part=3D1
