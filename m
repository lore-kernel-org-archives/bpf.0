Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332E23128CC
	for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 18:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782413606; cv=none; b=osySv/N9lRi8/Gk0mvVi9lqMY3pcYTLNTrwxmT4Zcg+TEd4WZqkWhHQ7f3P1X17Hn+ANBATTn89agbmrTw4y1Os71an/h7u7HbSy8/HkLGw4jARGcWAdynDypiFccaZVc0sd2SwP+LFUy00DrBeS9de1g9fAOOtTwK3JFXPCrek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782413606; c=relaxed/simple;
	bh=jX4tjDS2TY1o65mCKlxOrdJcyr8jfpPpm95ymgwH6o8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A+9TD1jxEFJpdvkTt4x35wRyqSyruLBKAbpjd/knsG4sQ+MICGfdq6sTmP1uLAPn/2VcEQVbaFWczWAhfQEX5W2D9c6kstHPEmtblPDP+MO+jv8hNnL7pm6AT/BChD1skrZ1PM3EAslbvip91d2jOeTmGjaLeGVAyZ7vvK6q/po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qKttOaDz; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qKttOaDz"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-37deb2d3a82so145501a91.1
        for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 11:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782413604; x=1783018404; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jX4tjDS2TY1o65mCKlxOrdJcyr8jfpPpm95ymgwH6o8=;
        b=qKttOaDzk25+CQnub6y7OvKXKEiCA8KpzD5HHFUpOh+DkktHoDXcKeO679lN4e5ehS
         B7b2MH0CamvYW4ojDQrlQaOSWl8U8ih13XYhEZmik7ug8GYommbP2qfuoGDoTQs9uhrF
         bykBr0ryFYT8u5/O9zavDNxh9D8LP1jc7JEja1eWBszdGDuC4Jtzi3kjc6yR3ioAA1Q1
         e3lMIzOXEfAUnaNkEanbuf5fPK7tZIisI2dtWFW2b6RlPk4m4nb+TYGBH7KHPHXsBFjQ
         ZaM9wFzi2V/i3MrpPb0lQ4nO+7mrqNCHqZAVEHEq0Fb9LRI1Vg4cmnoQIp2kgsiOuOy9
         /G2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782413604; x=1783018404;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jX4tjDS2TY1o65mCKlxOrdJcyr8jfpPpm95ymgwH6o8=;
        b=oabao4X+g3qzmti1WuXVBNF/cfBi3qWSqjTsN5SLBcFeXKhR5Z83Vt1nvPkO07JzNy
         as/h889oSEUYHMZAirn3Rdd7VJbv5dlcXSDeD2qf06dN12gvNH6usEsFP02pJZDHglg7
         Wo+B5cMrlo1LyLjRIhVFESYf8RvjOYmhw7ltWL5WYc/hCtpr+G4mb1AQIjhIzalh9o0M
         /XdcM8EosiWCRpu5NOhwxxwYgUj3NRQsseQ03q9P7BYLtY6V6MONRAKvdmJKbD1axazS
         HAWzomcjEED4uqDlcHDh4PHDBDgf+Lu6q+s8ostsxcCh8XE41+3xlWNKJu/GxQCa6p7m
         m9gQ==
X-Forwarded-Encrypted: i=1; AHgh+RoBahPbdspIh7ZXyQKRtnmKuq+fbjzOO9OEk5/C7uCFsePdJz+XNufeECoS5BDSGmKDmaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzelJRfl4iVRMPo3ltoyntSu9NycvnHuYUaXFB8yVAF9VyrlfuG
	jcqfPbQ7YIPGXlqoLYd1xagJsr9iF6BePjwZVr0FnsD0BZkc9k760X8F
X-Gm-Gg: AfdE7clPENlaNUs2iXrGvQCXB4W0EJKryih2zf1M1VkWnoLkLz4ZuxehLP7kKVUgJXJ
	JFitAjr542Q6PYgH/dV7i5Ig+WitZNCNrbkkaL51urjLFQMiFKjEu/8VdhnXJarx0ALOYN4J+HD
	uWERkVE504ZR73zGHv5RSA1Cb3oD6WBfIA0mFR/bWxHyBBZ7D3DZ97++IVmUX+dY7G2XQS/9bR3
	EwlD2D+kxRKf2dPn5rrwGot7c0MzAvs3g9ECaott1UnIlqQm9EPAn4K0CwNKDM5yWuSbbzV4gcY
	mh3w4Sc3JrTWJzeD7hxdOFWNJRNzkCFGRo9O4oEqo+iZ0p8MQtmht4dyYaVr1dGzPQ170GMIAjZ
	pMzdcgEH4jQh31dLotua6SZbBbjr5vPqyXdw3miO4shxuTJevZnI+fomytUMbhbQsyL6U+t59ht
	Gq5Ev6U95kFCFR+ikJQmwFe1SeAJkI8EkMj1S8crv6+8g8KAqzLioY
X-Received: by 2002:a17:902:c40e:b0:2bf:281c:d2d3 with SMTP id d9443c01a7336-2c7fc7300c6mr39782095ad.9.1782413604402;
        Thu, 25 Jun 2026 11:53:24 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f63d09f0sm26396125ad.56.2026.06.25.11.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 11:53:24 -0700 (PDT)
Message-ID: <01858c50447df77199abbe570d3ce06288200721.camel@gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: Avoid eliding lookup NULLness for inner
 map templates
From: Eduard Zingerman <eddyz87@gmail.com>
To: Sun Jian <sun.jian.kdev@gmail.com>, bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, 	martin.lau@linux.dev, memxor@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, 	jolsa@kernel.org,
 shuah@kernel.org, dxu@dxuuu.xyz
Date: Thu, 25 Jun 2026 11:53:13 -0700
In-Reply-To: <20260624072031.735846-1-sun.jian.kdev@gmail.com>
References: <20260624072031.735846-1-sun.jian.kdev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-06-24 at 15:20 +0800, Sun Jian wrote:
> Commit d2102f2f5d75 ("bpf: verifier: Support eliding map lookup
> nullness") allowed the verifier to elide NULLness of
> bpf_map_lookup_elem() for array maps when the key is statically known to
> be within max_entries.
>=20
> This is not valid for array maps used as inner map templates. For such
> maps, the template's max_entries is not necessarily the same as the
> max_entries of the concrete inner map used at runtime. As a result, a
> key that is within the template's max_entries can still be out of range
> for the concrete inner map, and the lookup may return NULL.
>=20
> Do not elide lookup NULLness for array maps used as inner map templates.
>=20
> Fixes: d2102f2f5d75 ("bpf: verifier: Support eliding map lookup nullness"=
)
> Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
> ---

This was already fixed by commit:
53040a81ae57 ("bpf: Keep dynamic inner array lookups nullable")
Please do not send stale patches.

[...]
