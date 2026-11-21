Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795225730;
	b=3l0WCXFg73wUbNsD1hgALRyEBWc5MaomepZmd8Wb21/HJx0r4iORUG1neUgXG4zCTEz9
	 M/wLmNdksAU6kpvS2fZb+gS2wydekd6j+fhQNrmpdvs/3kWGjuiw5Mj7tkiJ4uZi/brHr
	 sVTQ58mr5920nqjT/Qj7Ms4vHZzowTG/oT3TMeohNKPM6v6bS/p/OXdJkVELG2qVF6hDe
	 sAdtyMGzL00QIwtS7hdJXWqkCipJjlEX8pcTGEjBq1Pl2m89QKSdfoU+FJSGawaCGcCtL
	 7cRSIG0m2C9M0PSXUiUvQ8e5hVUAjnV85wbr8ftK+zKdQZAzVwoLlSHNvK4AvojeCLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795225730;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=60a0/HLjQTWhu7YxyY2UEEVoE9Eqcv8bbTKkNoYxrVU=;
	b=48q2TpZ0c8ZdoCvYW5FPuzLWolXdaD+eKS9vvK7PCuV5G6eu7Zu9GOyXnTPt3cBGcwHU
	 jiRh85XAW5a22zKucWxZ5ijZrj/t/yqny6g9JJt1HwiySZKA1VIaO9WI04a4Tq2ToeStZ
	 G6+Nlh9+OxWy/TWZScXQ5vFQE+fYPJPOyLFGw6CV9s7b0eh1eM94Ywx4NGssX6KsXKEgG
	 uWUfg0ZAVyYaLOzX6y/lR4HgG2j0dJooxd9jBtuoVPJ2zJD1PYRJRUxh/peBiTkErgEgt
	 mPmexObJSTfWgT9eOTGcohDCiR3rvz0/8OgzmCH4y1G+9BamPiyFTS2JEsJj22QlsGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N40mHX22;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A869606A6A2;
	Sat, 21 Nov 2026 01:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N40mHX22
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B80D21F000C4;
	Sat, 21 Nov 2026 01:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795225730;
	bh=60a0/HLjQTWhu7YxyY2UEEVoE9Eqcv8bbTKkNoYxrVU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=N40mHX22hiSdLl/o8DWalAzTkbUmui1KdIgMdy5VvUnr4GVU2gdnsfJulDn0omqRR
	 Vrhosooi9JxwrruXJl+AwyWt4ZvHiPpEom9h5CdOpaFmmpv/AR6H31bDDy+JA8oGHg
	 cEaORx2hcLGflzX0rfq1oJSJ0SjXiRWZ11PSTA3Rs0WJVT5MFBkE3wDr0OSa3PdKJo
	 Drm/4MdH56c1xsDqtgihZKpKDQFoxya3Cp9njLbq/XAhW0bwv9b6APRwTMpJx156gh
	 6VnFEO5E5hF0Dsax3n0aJTtIG0ncqWgre4XxTXpciPS+knOZKp1qXMexKxrcFjcL3h
	 QhMpQ2QgIUaJA==
Date: Fri, 20 Nov 2026 15:48:48 -1000
Message-ID: <0c503fdf9f38c1b7d2a5853f43609dd9@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Shaojie Sun <sunshaojie@kylinos.cn>
Cc: sched-ext@lists.linux.dev, Andrea Righi <arighi@nvidia.com>, David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2] tools/sched_ext: Add "arena" BTF type tag to the __arena qualifier
In-Reply-To: <20261120094934.979574-1-sunshaojie@kylinos.cn>
References: <20261120094934.979574-1-sunshaojie@kylinos.cn>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Applied to sched_ext/for-7.5.

Thanks.

--
tejun
