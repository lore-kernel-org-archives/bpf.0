Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52FD1F4C8C;
	Fri, 13 Mar 2026 00:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773362030; cv=none; b=YaL3NgW/ZsmgRQRBzKmNckmmlCN8GEIdHMVZ4Kb/mQToq7URkk6af9c/dNyNIQ4o1ND7fisWkaqAqu1YnJvKgJZLO50qLFlvEUNRkTUWJJmhKzgFZqTMGkYTCJ0bwW50L1sAoWW/oD6XZEVzPWs1Mfg6QVpzt9vD87Yjbdt9jj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773362030; c=relaxed/simple;
	bh=WZE3A5bMCdIsmSSV8Gu15uOE9e48iXTGvQrAbHKmUMI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IldiFiNLIbOkwMNDTLPyBqETjiDaQN8EjqtqrjnPK/0+MoKF7LF8jD5soicD2Q0/JS0BYRrvE2L0Z8/uIXEMJFndoMb+wrcCOah0/0o4cdWNUYM9N/lyMsbdqXX0m7zqXyyxHhr1gaJ8X2qeM/ukWS4njD8ijnK9yhQDPSU/hAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHxgBBXC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHxgBBXC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20A41C4CEF7;
	Fri, 13 Mar 2026 00:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773362029;
	bh=WZE3A5bMCdIsmSSV8Gu15uOE9e48iXTGvQrAbHKmUMI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hHxgBBXCeqb11zNHvhv4W9wsZNcgFOOi8M3cjfFSehbZoli9d1nnA7BWnv30+O4xF
	 nIMJHTE94tkuvbEstxctjalPe2Nc2EVYmdixuXyq2gWNLWy4ffNSTt3Ar6NBvlsM0y
	 AeGV4JM9T/rxdqB7i1p1XDBNJhNvTLGP1j4RWhyvtdVwxnbxXcPa3MGQH0E0vEUXGq
	 Gc2Xa58Q8JQ/K2LUK+CZFdjjcA+ABJbPEZX3rlmq5MwC/FTB7FU7FAHOo2wb1IbYu/
	 rwBtn7tw46UIqNUgKHE0u3XjZ4NzTRUHDR8m2pV5Hof6M65hlZBIV/uiWManenahIg
	 msK4JP2Q4dV2g==
Date: Thu, 12 Mar 2026 17:33:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com,
 pabeni@redhat.com, horms@kernel.org
Subject: Re: [PATCH net-next] xsk: use __xsk_rcv_zc_safe for ZC multi-buffer
 Rx processing
Message-ID: <20260312173348.4e70cdec@kernel.org>
In-Reply-To: <abCUMtO8Trtzs23d@mini-arch>
References: <20260310133024.422464-1-maciej.fijalkowski@intel.com>
	<abCUMtO8Trtzs23d@mini-arch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Mar 2026 14:59:14 -0700 Stanislav Fomichev wrote:
> (build bot seems to be confused because f620af11c27b went via bpf-next?)

The pre-req is in both trees now. Please repost?
