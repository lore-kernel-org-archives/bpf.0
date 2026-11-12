Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794513456;
	b=JiE/FHjLcAeVx0ntML/peOsG2nfWvpj8F7BX4Ez6Do0hLN4Q50LgkuJAk3b6ttuFYtCo
	 us4JajSAolgJcrHKh5BxiwH5G/rG3CcnKx9W1hF8tM+I2TIYOOZS7+ZWOrHqpXKbQ6/xi
	 K0U2+1WpvFKNkj4RFNHCG04huhNRc79cud3NlwChvzPwiNu65WJ/h6c42NGTmzAfIlv0p
	 4v+syLX0s4+1jVQDgIY8XoycPTjKAACcUSj26gNdLZhjy1FeNXjs9iVyOx9crB/nftP0v
	 TcgrxNgPclY0iGKgQQ5ddgL3tMYkug999brK5JHeoc2jlxLJr+lKSC9iv/OcBKVBAPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794513456;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=nG/lLkqQ0rdJBUmgF+0ZHDQjmdqunn63tZ9hH/Qnp9w=;
	b=bp8sxxWn+bo5a8iVId20VCatFDviKaGJRh+6arK7YATHlmYLxOmGP2KzoMeg1TdeH6Mo
	 vptVUGkqN+W78gPIlnaFfnHlzx6A7Bbr9tU99xSp96ZmLiNoaJ4b9cQ68TOyDIa0XaU2+
	 BGwyRbeBI6O0bPWGYW6m5Yi3h70GXp/r1n9hYnTTVDvXfFfQ+oAIzCJDPtNxLw46tEuK5
	 3+5qmsQjjJk3nqfSb1vQ/p/qiuQHX/KKPgK3SX1Jg2E5ewDm1FQ9/i61eDVRypXxsjTIs
	 +sy6+blgYtxi8t0hGlltTEE3X+vhk6Y+Zi32oP5ewGoCXDpUZ0KRitDgCnJ6OSXnSNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YwtQlMy8;
	arc=none smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30F4606A321
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 19:57:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A30F4606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YwtQlMy8
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8a39e5161c1so198502b3a.3
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 11:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794513455; x=1795118255; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nG/lLkqQ0rdJBUmgF+0ZHDQjmdqunn63tZ9hH/Qnp9w=;
        b=YwtQlMy8tzw38kivYwSxsVaNkC48NjO6zR8HMolDidk13wZwdwL8G/pT8tl/GFrfTG
         u/rerWG2qSjiC3eGgoV7XJBnRYu933lNqf5mqTQE9Z1LonLa1ldVJeEtpCDScXlV/u7T
         a4iklcV9UQfu/chino4vWs/c47DgX3ABVgT/1gCYj95tTh/kF6piFL97/1YEWUHAztky
         FBO9nwTGkihc8nXWTBcneYJBqT4vj3d9kj/uwpci+pshkcSThMNHate41TMitBuvpu6I
         j/eqehGvkpxbrTAiz/a9gbU2f5M6+k3yBvijC31uB3NJi3I4uzcxiNn5J7IMPlJH1KBY
         LjMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794513455; x=1795118255;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nG/lLkqQ0rdJBUmgF+0ZHDQjmdqunn63tZ9hH/Qnp9w=;
        b=LLVl0XooMFbg1XddlemElyR7m5fKYl38BzLYTRzBiD5J5tVkoXM29VmclTVU5pg+l/
         7bHAKHnltrATEu7kf5HLLvH7BOhcrJ2Hn0sOtSnaayaDzypE8+Fne8n2hJ1Su7pdSMj1
         7KNLcwrH6O+VNCJe/MsxJOalF1709X+f6PStQarDPNQsrO7fhxCUEjP4aq7M9RBFrCyp
         sqZCXaZ0YHEC/En/AOQsrEGNVo2IscGp8VO1yiewJhQTJqnDPQ5GD/HRqbozB/C7epwW
         n4+wO935vgwYgsygi1c2JtMK06JfyNEhVY3O/yL+yijPYm5OfHoM3mHChVk9Os+74lz3
         aQ/g==
X-Forwarded-Encrypted: i=1; AL+hErESE8qbOdAQh2ti1YiNq9UUrrrJCBG0e5LH5lT4uJhk0RTUpA0CA0k/a/cfb9KNJJJO9RI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+6D0B5bwHXrHvvt2QC4i+okQfET7c434+Dno9TOTUsJ/y51eDD
	/8por7HgJl3JqTnI5/ceHqDZOPz6oD8Gv6TSpw481+4PMzMGDluLPopC
X-Gm-Gg: AYBFou1/CU9f7mdDmZmhI3RrP3YDWjI1dnEm/ZvfpvZqyrqdESxN8c5Ny4VfL6KT8sD
	CWgjhgSdHvd3owszzu38fqgKSur/a03uAPW9rlBRpoCFE5nfOtujvK0trHewY6/DZMxjraHPbZD
	9jUTG/+LU8WTCqKpBAjk9vkb61pX/ldXpgqVOajzviGpzdKVBX20JFYrDRc5I5KPuf20S6xeyVO
	6S/DYFkz7jdwOvAYECyqB1E1VB4fBc/+YSfjbgEDYYeatIA3vsu3AfVnb7NBi/SMoKVGPA7hnEn
	Q8vIyZPvuVX9l4seP+l/hF7nqWqXDV+r7j7svphj4CexQiC7sbjJzJSlV5B8x4QEUUOjLhz5Jr/
	IEZL5kFQKVVZSwoL7uieheqpi4qx3hnvMKspwuJA4pGt7kVBdasnLKUol6IPlIs+TNEx1kYSgsA
	XSYQaF7SfckfoJez0+tUrSjfcsnDGzQ2eL4anYRkg+NKmC+9cwJUAwFEvub6DgAb5kBfaPboG5+
	6vEGhji3SZI/AHHW0cShHFZbvaECixUelNYx+xV44p0G7udLNL6xCLSi4cFLIlJK8aFIGwL/xmW
	qnm1cmPc/0bkZvK6/ShbrPQ5idBdZi55N6j7VttUBdEUq1T6laUytyCx3H8EfLUuk451wW4dZ3s
	/TPMgd0D1vpHoviyMs/tbnflXar03fbMmuis=
X-Received: by 2002:a05:6a21:6b05:b0:3e1:8300:f6d with SMTP id adf61e73a8af0-3f7a8cd3babmr195219637.59.1794513454592;
        Thu, 12 Nov 2026 11:57:34 -0800 (PST)
Received: from localhost ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed2d11ac8sm91909b3a.55.2026.11.12.11.57.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 11:57:34 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Nov 2026 19:57:33 +0000
Message-Id: <DMTHXFS504S9.2BU4PDLEWG3PX@gmail.com>
Cc: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, "Alexei
 Starovoitov" <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Tadeusz Struk" <tadeusz.struk@linaro.org>
Subject: Re: [PATCH] bpf: Fix cgroup link update after a failed effective
 array rebuild
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Shihuang Liu" <shlomojune6@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.20.1-355-gf870624f6c37
References: <20261112134942.288831-1-shlomojune6@gmail.com>
In-Reply-To: <20261112134942.288831-1-shlomojune6@gmail.com>

On Thu Nov 12, 2026 at 1:49 PM UTC, Shihuang Liu wrote:
> replace_effective_prog() uses the position of a cgroup program list
> entry as a physical index into the effective program array.  When an
> OOM detach falls back to purge_effective_progs(), the detached entry is
> replaced by a dummy but the other entries keep their position, so the
> list position no longer matches the array index.  A later link update
> then writes the new program into the wrong slot, leaving the old
> program pointer in the array.  The array does not hold a reference, so
> the old program can be freed while it is still published.

I doubt you managed to reproduce such scenario.
So wont-fix until there is one.

pw-bot: cr
