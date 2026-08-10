Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6CB3AF66E;
	Mon, 10 Aug 2026 13:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786368574; cv=none; b=dfDPIaPFy42lLFFHnGzjPP6SWJUWrQ4DapBeAYxu1E3oQTSdGe9T/b3zpmOa4gdjfQBkS08tphEPt2Mjps5V4Nkkd+DCKuFVExhreSIIYy32DoiOwIfH86peLhEKspF2CMbemsvIV3hCV/L3jqQencYTMb5q3OzHWtDq8JvkrbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786368574; c=relaxed/simple;
	bh=KXCcf6nwuOnmZrktueXWuAXBqHyjEjHxcBuKHud7Wdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WN4TYKE1J4cIckBJMA+XBaSxWxgtqAf50gKDdDCMoLV69tC28J3sgBOoABQ1ae4Gp3Yema/ks8jrScQGjUeTCXiatF6kVpl5KAYLk/5kprRXRhcEE2Vd7RCeDElGf8ONjZ3OIPYCohhqWfVqijWouy0KumXfn3Of68h4OTllKDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UD9KPDtb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UD9KPDtb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7808E1F000E9;
	Mon, 10 Aug 2026 13:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786368573;
	bh=heUncayR84oknNP0+pryzTxtZ4yXNwz7xAu3TMJorSw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UD9KPDtb3HlBfEX2zMMdFLxjttCuNK3rhhgf7SD6UCYs23525QpUo3V0Jzuemmp85
	 p+3CqzXucgZUe6FrL8zbHFntNQzvGb/VTpb0Gv+5xTemLEtki4CoYZ0I10YgX0+ISm
	 SJuH3injnirybH/PrWcP1udVravhj+QbFplW3IC/eI2B7IttCwhDnkKYXD+Peg0TKs
	 jcG0pwokqlred0uqIRBaPlHgis0pUeta0TEn8mPi2xDZNYRmXM8mfCoHJIWRdIEcZW
	 ers15AmDzgztBPl1Sf+c9GPxlYfMNmbKsdAclpcSWXWU7KDBkVKCxSMHzAFSjbDUxG
	 aeD+/cyVvL8Ew==
Date: Mon, 10 Aug 2026 14:29:29 +0100
From: Simon Horman <horms@kernel.org>
To: Feng Tang <feng.tang@linux.alibaba.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Andi Kleen <ak@linux.intel.com>,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v3] selftests: net: reuseport_bpf_numa: consider
 cpuless numa node
Message-ID: <20260810132929.GS51943@horms.kernel.org>
References: <20260807002436.43991-1-feng.tang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807002436.43991-1-feng.tang@linux.alibaba.com>

On Fri, Aug 07, 2026 at 08:24:36AM +0800, Feng Tang wrote:
> reuseport_bpf_numa case failed when testing on a platform with CXL
> memory:
> 
>     #./reuseport_bpf_numa
>     ---- IPv4 UDP ----
>     send node 0, receive socket 0
>     ./reuseport_bpf_numa: failed to pin to node: Invalid argument
> 
> The root cause is that the platform has 2 numa nodes: node 0 has
> both cpu and memory, while node 1 is a CXL node which only has
> memory, and caused numa_run_on_node() to fail.
> 
> Add sanity check to skip cpuless numa node for the numa binding test.
> 
> Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>
> ---
> Changelog:
>   since v2:
>     * fix spelling issue (Jakub, Sashiko)
> 	* remove unnecessary 'inline' for is_cpuless_node() (Jakub)
> 
>   since v1:
>     * address comments from Sashiko bot
>       https://lore.kernel.org/all/20260730113738.41C901F000E9@smtp.kernel.org/
>     * lift the cpuless node check out of send_from_node() 

Reviewed-by: Simon Horman <horms@kernel.org>

