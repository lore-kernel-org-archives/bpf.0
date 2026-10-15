Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC2F4AA006;
	Thu, 15 Oct 2026 08:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792052090; cv=none; b=OkJOPHJnfMXLNf0L3UhuQaWZU2XvXfl5K8nQ4Vs2dMw0LhjlAK6W9SvDksumPtAHHuGJzo57VZrg35DUZi3QcCzIakZ5tRNvDsEO6ycJgMGCxhE2dJusKiP2evMe4RIpXn+Sr92ytsNuSrFYDpBRiUWHVABsr4Lig6KkzVCBQ1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792052090; c=relaxed/simple;
	bh=TuDFHIjV4ycg72SjphuuUS32PxntGIc6IJnSYay/XaU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nPVrTKSQr5wQdYTJC38hwGxbjPBb+McI5KAJLpW0QG3tBa6GzfQmmvX08T+rEkhff1CfL5I3rf27bNoaVf1VWDQugoZYOqEPAExeZds3gJMoVte+a0nuCHsPCfeWxJGmSoHt80WJlXacbWVdFB0WqRGln6fQdJ0khV94Q0S7EWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQZlcwBD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQZlcwBD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C02F81F000C4;
	Thu, 15 Oct 2026 08:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792052089;
	bh=TuDFHIjV4ycg72SjphuuUS32PxntGIc6IJnSYay/XaU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=RQZlcwBDAmeYRs4Q/iJKTtgaELg/FFE3/W2zFrNKTp+SPd8ldyCN316R9/9RadRdZ
	 kPAW5C8JC+0Guo7VWbIm3VLAOFPCIjPXMKO1tF7eDTEIIZRpebXG5V6XCfWRHzc/yi
	 sVVZqnhYVEjTm1Xb6Xf55Phh5XhjcZbfeKw91jMA5JEXTNUBk+vX/ZR8kQisxRNtSN
	 4ZAvcUe0IXuoT3a8+0HYNcLSjYQWe861f/E8rGZPLOBfIfhDmcjbk0csygtYhAWluj
	 8ALetvgoF/apSWl0qi5SwtYOOZq+9OTi1J95hDGdelGYCjnosoyK/XvijPT6LhXZqr
	 deOqmt6ZW4aMA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, magnus.karlsson@intel.com, stfomichev@gmail.com,
 kuba@kernel.org, pabeni@redhat.com, tushar.vyavahare@intel.com,
 kerneljasonxing@gmail.com, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH v3 net-next 01/15] selftests: xsk: factor endpoint work
 out of pthread wrappers
In-Reply-To: <20261014184539.774708-2-maciej.fijalkowski@intel.com>
References: <20261014184539.774708-1-maciej.fijalkowski@intel.com>
 <20261014184539.774708-2-maciej.fijalkowski@intel.com>
Date: Thu, 15 Oct 2026 10:14:45 +0200
Message-ID: <875wz38jnu.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:

> Move TX execution, RX setup and RX validation into synchronous helpers

Maybe it's my rustified brain was messed up by "synchronous helpers" --
"extract the work into functions that return normally" ;-)

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
