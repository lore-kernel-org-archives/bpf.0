Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E58937CD22;
	Wed,  2 Sep 2026 06:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788331373; cv=none; b=A7eHbBnmHWvMhrYspXQ3BFm7nB2OdUTDdfG7e1ztp8CmH3B86DWS68klcC3otewT//HeL3SpcSBeaj2AeeKgUOl2nKFORyjn6YTFRxR/hcuebyI0qAwochpaGaT3+2nf1X1+zJjVZdrrdjC7Dm0N7lNsr/CuzzY+IImxrzP/0kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788331373; c=relaxed/simple;
	bh=MkHDGOrhcy2o+SJeYss1DqIYBNnUt7fFtbgQKc5C8N0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=sk7VFl6WD0EZE5TO3tw3SW4tsiZVrdPuY5AZNCKb0cGLwaonOaLIJTZc6w0bnPUG6C6q3UCIlbB3tOANz3nZk0iyHbXDrf4Hou/HQJleqYSqEqkR7zYyqUJxdCO8K9c3v2TFhsYiAgyPXTeJ/B4nknkNMI5GoPEsBC/RZLkmG/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aoiPKJ9W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aoiPKJ9W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EE981F000E9;
	Wed,  2 Sep 2026 06:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788331371;
	bh=h9qF2enIKFzWkgyEIFlw9mB3wT5BWHNZWJWqQ2AkWCQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aoiPKJ9WBKDmaPNmWJez0U2vDHWFTAbT32vyHrWZgVjWFV3FtDY145PIDgyaIrLdv
	 LJOyh/pnDnb/IdiHgjEW7eI+aoYqExtXpepSV2w8qckAmIzt0/6YecU0KMBl+vrdlY
	 pboMzKVXAU/rbOXUmIoudTmHxip31qxYLHjNuv4I3/qEXW+fk2WWF8mA5FkX+o00AB
	 tIx6Cte0FBBI9X/tzzvjPjZNmleq7/kOR8zmi4GGX98Y1MEDKuc2pF3hKElHWW4wz+
	 4+Ortpr5QINMc8nA0ae625lLICnEZqENP5lnYj5rJv0/tcN7HrmoU2I3zAPs7PNyNj
	 KIuhgxozebThg==
Date: Tue, 01 Sep 2026 20:42:50 -1000
Message-ID: <752cd2e42b6161465a7644c3085ce924@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Tao Cui <cui.tao@linux.dev>
Cc: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com, michalblk@google.com, liwanwu@kylinos.cn, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH v3 0/2] sched_ext: document and enforce vtime ordering constraints
In-Reply-To: <20260902024812.794879-1-cui.tao@linux.dev>
References: <20260902024812.794879-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Wed, Sep 02, 2026 at 10:48:10AM +0800, Tao Cui wrote:
> Tao Cui (2):
>   sched_ext: document the rolling-cursor requirement for dsq_vtime
>   sched_ext/scx_flatcg: make cgv_node_less() wraparound-safe

Applied 1-2 to sched_ext/for-7.4 with the subjects capitalized.

Thanks.

--
tejun
