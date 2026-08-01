Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECBE356777;
	Sat,  1 Aug 2026 00:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785544125; cv=none; b=Rs30BT0tvEg9t326YDB4E9IOcriNjQij5G1ItZUVF9Ts+dxOLY+N+Wl6c0C52ttEQLVTMeOSzeDaCakMPNO8AwlyPyNg7/VTQ4RHNpaOUtlQDT7CQjTQEyEsNwQkjRdnv2jOFUf6/gJrOZ0rAaXWyvY9RsWWHCIf95ZUZ8OelUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785544125; c=relaxed/simple;
	bh=lUuQfJ4rW9ovHzwB6PW3+R0D6QJxtafyi4JfwXPOUXc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zi7a7jAGsomY5I/+A6HLIhr/iqHHlyJ8nfCw/DvAe2pKO8208MfJd794imhgQNVOeodtRTxuDoA1AmncYU2W0Z+jAoIseh0dnSVV0GqhJWIysdk5kggT+suVEAYrYIoIcgNUqm/WwqoyYLhfXn5f1f7oGKtQ/ZD8aXSd1esd008=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZd3FuU6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZd3FuU6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59CA51F00AC4;
	Sat,  1 Aug 2026 00:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785544120;
	bh=ZDj+qmccGAmWzA+5akNEOGwlhUUsMst50vIc/+6l2Mk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kZd3FuU6yPiw7q7JEOanr4Q5+ct/HEHy60gk098y8yFf4c5BfgqsNpHqF/ed1POlX
	 eZLoAtj1iPTwaWRI2/n1hfcG2J9XeQaNBSab30sfcmSIRY3pgCCcHd5/h8it0DqG88
	 mR060nMOwY7IZti6ncQRj6j9VdJgDS7Zcm0yfHcGh6w3DmgfJXUkslsZk5WfyvFZ2S
	 rfmNP4ACdVJxg4xu9W7thGF++zBybkmhRlKQwV+Vg9pne3VupmMzenCySdvhwnQlif
	 t/xoIA0eFabpN+/9z/e2RzI0RhQp/KjHgQCMx/nnHUspTBiVbOIzsKndUrIwNjoHMy
	 24WFtwWRLCQqA==
Date: Fri, 31 Jul 2026 17:28:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tushar Vyavahare <tushar.vyavahare@intel.com>
Cc: netdev@vger.kernel.org, magnus.karlsson@intel.com,
 maciej.fijalkowski@intel.com, stfomichev@gmail.com, kernelxing@tencent.com,
 davem@davemloft.net, pabeni@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, tirthendu.sarkar@intel.com,
 andrii.nakryiko@gmail.com, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v3] selftests/xsk: decouple xskxceiver and xdp
 apps from test_progs objects
Message-ID: <20260731172839.70442a17@kernel.org>
In-Reply-To: <20260728115036.2049536-1-tushar.vyavahare@intel.com>
References: <20260728115036.2049536-1-tushar.vyavahare@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Jul 2026 11:50:36 +0000 Tushar Vyavahare wrote:
> Subject: [PATCH net-next v3] selftests/xsk: decouple xskxceiver and xdp apps from test_progs objects

>  tools/testing/selftests/bpf/Makefile | 19 ++++++++++++++-----
                 ^^^^^^^^^^^^^

This needs to go via bpf tree, the Makefile is shared with real BPF
stuff so we better not cause conflicts. Reassigned in patchwork,
no need to repost.
