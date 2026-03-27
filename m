Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F76339B2D;
	Fri, 27 Mar 2026 03:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774582043; cv=none; b=RvOupAkCEecihkIpaCbarEYzRmlFkNr8YRI2L9nRDFMdoOW0SBln8xiN3HV0n53uc4VF+FMESNSR418CuR96qQ/BsdqySEOr18GkfLkjs3lAxIEUy4fScvDXXGANNBLyz83CqpsVbINvxddJt6QTeiWx5wfbenZjKyeV/w0A/U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774582043; c=relaxed/simple;
	bh=Hvswcyf4XcegOhhrt+Ac6iyUCkTQdURX3j0KKowqp8o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ijS068uoe70Xk5TgewSXpYa+SxTQMZvU4jNZBCm6sR1cQz/fNANaX5l3Vx8js/FtgU6DEpe3Xou2viHCKw5H+gOEIJsemG1bm207AiMJMFRNSrn9AKQcpiJvQmcgg8dWbI8NCqrdiUfqGpCzAElSpvn+RGXwVKfXBAcZ/Yoetm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKEjTzmY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKEjTzmY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92FDDC116C6;
	Fri, 27 Mar 2026 03:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774582043;
	bh=Hvswcyf4XcegOhhrt+Ac6iyUCkTQdURX3j0KKowqp8o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RKEjTzmYJSBzzZKe1c6oLTL7JDyvev5Yg7BrQN1lEaqslwQt6tuAGZqZI4avHir+f
	 bmF82R7zGwBkAXFJadTYGme948naVLvtnJ+cxgr3Rh2OXCl19ApQp+6QW6Q8+Q3zEx
	 yyXBQRRjqfN53oVUMIlvhoGrRIb7zlSh+qod8dB7joIeAHs0skHRJvIBcI7dZULnfg
	 u3wtjdDrFN0/9jrBwe4/AI8x2A4M8RL7F2LHiC2+Q1FOtLI30N0V0nhOIhZrOoQw4s
	 J8yCasZg2ZLcgbQl0wI4gdDXsjDYaSsko9cSXpnPeSr79iX6MKDGFBCwDlsYu4T+c4
	 N8ym2vm6Av6dQ==
Date: Thu, 26 Mar 2026 20:27:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com,
 stfomichev@gmail.com, pabeni@redhat.com, horms@kernel.org,
 larysa.zaremba@intel.com, aleksander.lobakin@intel.com, bjorn@kernel.org,
 Ihor Solodrai <ihor.solodrai@linux.dev>
Subject: Re: [PATCH v3 net 0/8] xsk: tailroom reservation and MTU validation
Message-ID: <20260326202721.37382070@kernel.org>
In-Reply-To: <20260323192457.504631-1-maciej.fijalkowski@intel.com>
References: <20260323192457.504631-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Mar 2026 20:24:49 +0100 Maciej Fijalkowski wrote:
> here we fix a long-standing issue regarding multi-buffer scenario in ZC
> mode - we have not been providing space at the end of the buffer where
> multi-buffer XDP works on skb_shared_info. This has been brought to our
> attention via [0].
> 
> Unaligned mode does not get any specific treatment, it is user's
> responsibility to properly handle XSK addresses in queues.
> 
> With adjustments included here in this set against xskxceiver I have
> been able to pass the full test suite on ice.

Please scream at me if I'm wrong but I _think_ this is somehow 
breaking BPF CI ?? It's the only BPF change we have AFAICT and
CI has been failing like this all day:

Root directory input is valid!
Error: The path for one of the files in artifact is not valid: /packets-132-3-net_timestamping__INET4:_bpf_timestamping-net_timestamping_ns.log. Contains the following character:  Colon :
          
Invalid characters include:  Double quote ", Colon :, Less than <, Greater than >, Vertical bar |, Asterisk *, Question mark ?, Carriage return \r, Line feed \n

https://github.com/kernel-patches/bpf/actions/runs/23624136123/job/68809559810
