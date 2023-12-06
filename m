Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EEC30341
	for <bpf@vger.kernel.org>; Wed,  6 Dec 2023 10:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dlPHHRot"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28DA0C43397;
	Wed,  6 Dec 2023 10:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701860121;
	bh=qsu/D127WynhbeDxs53GvaKwbcGTjVM8SoeiPkFxorM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dlPHHRotmXZ7zT+jOjv7e7+NuBuSYZT2Nk4GnZRbloP5MFrbGI6+8RUJbRFX+LHYw
	 TmuHOTSAwsdzlOFBsVwiI1RuTpjv4qHu9RORbu8D8uk7kzILIRwwxSrwaujZ/EGS56
	 tRir3uAXwEThcglfbVPx5cpG8W23F/lJQ0QVlhaGRm9GNnO3wkPCzSuOgpPS3hVfbs
	 f1ZRaryF8oIzCJn1ewnjm7XBQZzuhnNlb5W6uRZg+79LVlkEa8gLNamLHA4huQoVFy
	 3DetIL3112KB097LDFG9cVO0sQtJeD0PM2NRjfDbACiZP6K2xfmOaTprVqPkkx7PsJ
	 bBMq7L6IDhWmg==
Date: Wed, 6 Dec 2023 11:55:17 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jie Jiang <jiejiang@chromium.org>
Cc: bpf@vger.kernel.org, vapier@chromium.org, andrii@kernel.org
Subject: Re: [PATCH bpf-next v2] bpf: Support uid and gid when mounting bpffs
Message-ID: <20231206-annahme-beide-976ce66476e4@brauner>
References: <20231206073624.149124-1-jiejiang@chromium.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231206073624.149124-1-jiejiang@chromium.org>

On Wed, Dec 06, 2023 at 07:36:24AM +0000, Jie Jiang wrote:
> Parse uid and gid in bpf_parse_param() so that they can be passed in as
> the `data` parameter when mount() bpffs. This will be useful when we
> want to control which user/group has the control to the mounted bpffs,
> otherwise a separate chown() call will be needed.
> 
> Signed-off-by: Jie Jiang <jiejiang@chromium.org>
> ---

Yes, looks good now,
Acked-by: Christian Brauner <brauner@kernel.org>
