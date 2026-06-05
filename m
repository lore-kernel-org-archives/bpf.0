Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902E037DAAA
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 21:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780695712; cv=none; b=CYd/DoqvaQsOd5lmkPP7hc2gVjklhXu/8kQ/L4RGiV96j9npVyeGdjLY94J9fk6BNhMCWX6I0H+B79PbrVba5ZG3fZ0uYBU2CZ99A+D7AjGjhWnKHP5mPy8F4jgIn3B78MfAMu2TiHc+5Q98vbHZ0R6ADoCdVFVPFQ2W6/2vVJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780695712; c=relaxed/simple;
	bh=XORlb5byBUCZFy/pJtOloqC6unOWTKk/BmLGZLS78Ng=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qq5JZWk5CQ37aNid/jWBjnHxMYyfRLKgC4LfZ7HUbZXbDRK0OfuJm/T1uuyLhp2pk/OmfIjEfCgTxX2gpLbblsDZ1/nXhLx5JsPw8QG0o0GCL0q/bZgitGrl3iQU31LE4YTROAgqQxTa2+smdICOM0eRlYVFNV4rs8zylRK8/wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wx/7Eucu; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wx/7Eucu"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-304e83724bfso2892846eec.0
        for <bpf@vger.kernel.org>; Fri, 05 Jun 2026 14:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780695711; x=1781300511; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dMVPmCIgTGtXfzsqyWhEdpy/kC/rRCnhptGsEBdv/Dw=;
        b=Wx/7EucubotmShNKwaC0i5JmRBtN5zXlNIeLcha7fy3D+f2PCSJRgo/9zEGwtzKj3o
         6vxmH0TtaJLXtIvcyuMBJBcKxWKYFkfzcG5tWcC2QTSpVtjtH6bidkw39mUVcI3Kf38L
         AEHoXOD68RS9XXsfIxDy4nNTuRI93WDcmP7PsUjEu1qBYKHxT/i5pCsAXymDe6DXii9v
         5SNNxog393T5F5oNPW2gL5lb+0KNxMdKP0KvPobo9lviD2En3Q8FvMrF+WHsRB9dVdFt
         uy8ygDBC3qLuPMZiGrqd0kWGmHRF8oqRTZzkeq7Zw4FR90tK0wZZmLz4HMMJFlt4cytS
         RLBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780695711; x=1781300511;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dMVPmCIgTGtXfzsqyWhEdpy/kC/rRCnhptGsEBdv/Dw=;
        b=Thrk3ryH0gqhH+9D/+bNXcbHTJpNs43yMO0cEuQPPV1ZvAiiisgIhRKQAhSJwsXLZ2
         xkRJHEZEeVWPp+3S+uNSKQs6IvSw1vpsz52sAdIFDuaNmOweVbJHp2Ls8D32Qq9IQD/m
         uksFCsYWPzd3hf1ur7l170Qyt5Y9fVBRD8e/807fROWPY38a3s2ICYGtdmBuUvvmWXbL
         mssMwoUtpPUENZNsrQRdsJGjKw8JVdHbQIwovLLGIeaPtZUyNVziXNrhigUMkuv+dGdn
         ZVUD6fXXNxh2b76LNPzVPpBCamS1qaZMLsy1x9kuIbPypRbexn1Hkfh73VNw2QuMbiCB
         mZDA==
X-Forwarded-Encrypted: i=1; AFNElJ86Tb+Ghm9FMKiUoCqkMhsjhJOm3kWMAWFfR9PkzTiiDSfsaPJXN5gbIPwuC2gM2T1NSDM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgy6eLTU7xpHvgz6T7cNbBhugcFLTgQ0g7wo32L0hoEDtOJauO
	T12Pa0kUp/t80S3dchQGmZs0NsbTGnAO92rcSFUIN5505r1+4wk9kVhB
X-Gm-Gg: Acq92OHDfHTK6qCEZmwQ2DW/8oDkZMJJmJbGaRPSXk387vOYFt+2iRUUB84EDyAkVNC
	SGLtDFzKMSbBShoP2tHzV2EupJszCjwcj1SJ9BmUtDoSH9fpF+2x1C3dXHSLYj73ZkTVtOR5PHg
	cwmokM9Y9y251LRMzfggqKBdHRZM3B7VmmBOD/d3mznRWrgsX1GMpybhUCMppgjOqEIKBmYfGeJ
	zPD/dA/uwJXR6nrpsluPWdVj6REpLNMMBwyDPcJurz7n+AahheuKRGk9vTRHh3mC7zOJFC7bCQY
	Si4x9ezE7guCubN2JZZup6lEevW3esEXNz3x920GzIfZozwytEQqB/USh+lqz4OdoA4cNsKMYh4
	2dmxCo4mzAHgiYucEVCub84cBoknyCpPa6gfGXv/Vh338krjinXvJ0+O5oqVDd8UhOQKq19pddb
	On4DFc/jhIL0BhTFqdatUsgF77uV+qeifi+8nzIdDnrLjEBzFby3qjTPpzJKDixDq/juv+B1GYo
	eYuGVl/TC0hPsKP
X-Received: by 2002:a05:7301:5f14:b0:304:b93a:5107 with SMTP id 5a478bee46e88-3077b594e83mr3068474eec.21.1780695710664;
        Fri, 05 Jun 2026 14:41:50 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:5171:6892:c6a6:f1b4? ([2620:10d:c090:500::8271])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074df77a0asm9556124eec.27.2026.06.05.14.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 14:41:50 -0700 (PDT)
Message-ID: <adf0cbbae3e7d128006ede2706a58e638124ae50.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 04/17] bpf: Track verifier branch diagnostic
 history
From: Eduard Zingerman <eddyz87@gmail.com>
To: bot+bpf-ci@kernel.org, memxor@gmail.com, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 emil@etsalapatis.com, 	kkd@meta.com, kernel-team@meta.com,
 martin.lau@kernel.org, yonghong.song@linux.dev, 	clm@meta.com,
 ihor.solodrai@linux.dev
Date: Fri, 05 Jun 2026 14:41:48 -0700
In-Reply-To: <fbfd6c93648afc57326ad44ad5fd9d6ae5a4e403b2a279a8298e8423751c9379@mail.kernel.org>
References: <20260605063412.974640-5-memxor@gmail.com>
	 <fbfd6c93648afc57326ad44ad5fd9d6ae5a4e403b2a279a8298e8423751c9379@mail.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-06-05 at 07:57 +0000, bot+bpf-ci@kernel.org wrote:

[...]

> Does this cause massive memory bloat when verifier logging is enabled?
>=20
> Because is_state_visited() caches states by calling bpf_copy_verifier_sta=
te()
> and adding them to the explored_states list, the diagnostic history is co=
pied
> for every cached state.
>=20
> Since the diagnostic history can grow up to 1024 entries per state, cachi=
ng
> this for tens of thousands of explored states could easily lead to gigaby=
tes
> of wasted memory, potentially hitting memcg limits via GFP_KERNEL_ACCOUNT=
 or
> causing -ENOMEM specifically when a user enables logging to debug an issu=
e.
>=20
> Because cached states are only used for state equivalence checks and prec=
ision
> propagation, neither of which use the diagnostic history, could we avoid
> copying the diag_history into cached explored states?
>=20
> This concern was raised by sashiko-bot@kernel.org at
> https://lore.kernel.org/bpf/20260605065017.D9F401F00893@smtp.kernel.org

I think this diagnostics history buffer can be global.
The way Andrii implemented jump history once:

  https://lore.kernel.org/all/20241115001303.277272-1-andrii@kernel.org/

(but we had to revert it for unrelated reasons).
