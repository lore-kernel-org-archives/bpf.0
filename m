Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620973112BD;
	Sat, 27 Jun 2026 22:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782600134; cv=none; b=M7mTaE7xdsk+yq6qo4gLd2Acb4Fvd9asEzkleK2VXd7+IyS33HpzrvW73nJAP7n6wuCsp9W2CJD7k7kIiNHSWpaaR0RfaFz3EHQ4D0Av08BMUR72keRNmxd4Sy5prUUCsVm2mSC8NWV3oTZLVmXfpqltwC0zNjaKPjORqVPFg3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782600134; c=relaxed/simple;
	bh=eCnQsGUFKlGLqmnsbUyFi5GKS0WYhvRrrIXshT/swyg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nZpkp5+uPKSd9byrPGbgepkP375MDITcOQ/fkWWfd1Wh8yrKcdTP645aE7VK9UF8LK7NAd5PQYEuoO6E6C7wzmQSfm191NTVTHF74mhBqKbfmL06txG0vELvS7RIuz2z68+qmEYQSgfDJuyacrd7J26rq5a1fF1SaGQy156VvJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rrt2w0Fu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rrt2w0Fu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8C4F1F000E9;
	Sat, 27 Jun 2026 22:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782600133;
	bh=+WU6Nm3UAzz1lJfTyKmC+aPncx0urnLp7yRTIpxGwaE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Rrt2w0Fuy1QK7DComCXc4aA8aWcrsQwNvb80io6wEuv07J+VXOt+quuloXHof1v1J
	 7uo/TFy8RLSMVmb4tstdowKJDkDEx/j6XuSV8uAflyAQzLmojgNgdGfW3mF4ASAMrJ
	 pQe/hsaQJ5ar4QgqoXbnDSO8cttSbqNMjGf5pzJrZ5ybpkNzNHIR0g9ZnCuu3ab+Fb
	 g1gzJ3v0JEYsW/I2liDGXVQrtwwrB7c45g5eWL/oPvXuFEC3nlBmnDSzpJzHMxGbvE
	 ddLWqTmyZfRH/PDR6Z7z4M/43jJ3y0EPLH5pk4J8FfiTzIuvs84GKf2Zo53LahuITU
	 gIZ2jlM4JLDCQ==
Date: Sat, 27 Jun 2026 15:42:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com,
 stfomichev@gmail.com, pabeni@redhat.com, horms@kernel.org,
 tushar.vyavahare@intel.com, kerneljasonxing@gmail.com
Subject: Re: [PATCH v2 net-next] selftests/xsk: Preserve UMEM view in
 BIDIRECTIONAL test
Message-ID: <20260627154212.353d9b1a@kernel.org>
In-Reply-To: <20260625115215.1101928-1-maciej.fijalkowski@intel.com>
References: <20260625115215.1101928-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jun 2026 13:52:15 +0200 Maciej Fijalkowski wrote:
> Subject: [PATCH v2 net-next] selftests/xsk: Preserve UMEM view in BIDIRECTIONAL test
> 
> Fixes: b17631032769 ("selftests/xsk: Move UMEM state from ifobject to xsk_socket_info")

Yup, doesn't apply, conflicts with the patches that went via net
but are now in both trees.
-- 
pw-bot: cr
