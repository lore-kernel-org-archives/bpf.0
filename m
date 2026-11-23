Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.80
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795411342;
	b=jVFJBh8D8SzIK/oHFaUmAqbem19S1B3UuTL7SKtW8zSfGY9fdO2XpbxB0z1hU/nYDL5W
	 BXmP3Ny5XqnXnGG5mjcUC00kpLI3O146FjDsLkPfwEbRn4fSZJo0gkZ3STSVWUZz3rFzB
	 9h5aXLQxb9KGIjSPe4VnLWsAtTKHQGvCIKYxdf/oPPJMTpGPhqTBqyJ3CqJrGxfOkRPv8
	 M4ekL4tQ8cGo/JRt4hQjCcRRrMdNxs04ClMfqpJU4xZjyGiDyqTNu85uoojaBjUb/KbAX
	 lGtuCDEpMcUdiP3r4oAmdCrcF96SCFVfp8rspnOTkPpbkW8G9CdoPpi4UHqp9komLzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795411342;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=iy36ClD91OuaesY/Ay9KrdFH02xOa7KlfGzGZS847ZU=;
	b=WEADHkIfbZn0CY1j2/uo9qljw7CRTfUoxllrmTY0u7AK2YvORk4vaVDVehe57ciJjKps
	 UdvnfPvAJPTriMH58/e5hBST/CDTWmbHspPIT2ySciHSXWtTFkyiQi4rTzOVjsGUInjP+
	 TzhGLtzIO/JyUyFTdDAemj/s0DmC4GYbtjPDdjvUfNIpHFZ1SvrbTUC9ifxdJXoumHcbN
	 OTz53sBOtfnbnmRl9QeukhpKTARMRdtUvt/BjD/fU9oIvg7ju6sgWuE8QxoU4BgbOmH9q
	 4p2PVT+9iFjPcRHOnOxFif7A58ragfZFeZtqZF+JPyP+Ye+8QLV2KSgfwzeXq9wqjDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="rorQCa/B";
	arc=none smtp.remote-ip=91.218.175.80
Received: from mta0.migadu.com (out-80.mta0.migadu.com [91.218.175.80])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D803606A31F
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 05:22:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D803606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=rorQCa/B
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=D82Nd0c2N+O4K4PuYhgfhJVwNjk6bdjRGsOrqQiK2r4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795411339; v=1; x=1796016139;
 b=rorQCa/BO2A211dkndlN3Z5a+4JYq5futjumyEheZuePk96gq4WCr5xxiiNzN0OOhnmMz6xT
 ZYy/qBo+xlUR66fL2yeW3qkEcIsDDLIhN3QNJbE0KaQZEtKr3kVQkRYp3Ks+Ws7sc8Yb57Wk7p6
 1lORLH0C+OVV/3QD07YeWkuk=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id d4f9441bda4b8cfe;
	Mon, 23 Nov 2026 05:22:19 +0000
X-Mizu-Trace-ID: d4f9441bda4b8cfe
X-Migadu-Flow: FLOW_OUT
Date: Mon, 23 Nov 2026 13:22:07 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
Cc: tianyi@cloudflare.com, kuba@kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
	pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, sdf@fomichev.me,
	skhan@linuxfoundation.org, kernel-team@cloudflare.com,
	tianyi.gao@linux.dev
Subject: Re: [PATCH net-next v5 3/3] selftests: net: veth: propagate
 bad-settings check failures to exit status
Message-ID: <20261123052207.GG10218@Liu-laptop>
References: <20261121182217.4609-1-emmaonana18@gmail.com>
 <20261121182217.4609-4-emmaonana18@gmail.com>
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
Content-Disposition: inline
In-Reply-To: <20261121182217.4609-4-emmaonana18@gmail.com>

Hi Omokefe,
On Sat, Nov 21, 2026 at 07:22:17PM +0100, Omokefe Emmanuel Onanaroghene wrote:
> Three more checks in veth.sh print "fail - set operation successful
> ?!?" without setting ret: "bad setting: XDP with RX nr less than TX",
> "bad setting: reducing RX nr below peer TX with XDP set", and "bad
> setting: increasing peer TX nr above RX with XDP set". A kernel that
> wrongly accepts any of these invalid operations would be reported yet
> the script would still exit 0. Wrap each fail branch so it sets ret=1.
> 
> Reported-by: Tianyi Gao <tianyi@cloudflare.com>
> Link: https://lore.kernel.org/all/CAG4wq-cd01i7YrcFPmma=BXUcwn_PK=wneKW=vyEBYzQ3Bn7QA@mail.gmail.com/
> Signed-off-by: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
> ---
>  tools/testing/selftests/net/veth.sh | 26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/veth.sh b/tools/testing/selftests/net/veth.sh
> index 7a2bbed0263e7..6eeb123aaf885 100755
> --- a/tools/testing/selftests/net/veth.sh
> +++ b/tools/testing/selftests/net/veth.sh
> @@ -474,9 +474,13 @@ if [ $CPUS -gt 1 ]; then
>  	ip netns exec $NS_DST ethtool -L veth$DST rx 1 tx 2 2>/dev/null
>  	ip netns exec $NS_SRC ethtool -L veth$SRC rx 1 tx 2 2>/dev/null
>  	printf "%-60s" "bad setting: XDP with RX nr less than TX"
> -	ip -n $NS_DST link set dev veth$DST xdp object ${BPF_FILE} \
> -		section xdp 2>/dev/null &&\
> -		echo "fail - set operation successful ?!?" || echo " ok "
> +	if ip -n $NS_DST link set dev veth$DST xdp object ${BPF_FILE} \
> +		section xdp 2>/dev/null; then
> +		echo "fail - set operation successful ?!?"
> +		ret=1
> +	else
> +		echo " ok "
> +	fi
>  
>  	# the following tests will run with multiple channels active
>  	ip netns exec $NS_SRC ethtool -L veth$SRC rx 2
> @@ -484,16 +488,24 @@ if [ $CPUS -gt 1 ]; then
>  	ip -n $NS_DST link set dev veth$DST xdp object ${BPF_FILE} \
>  		section xdp 2>/dev/null
>  	printf "%-60s" "bad setting: reducing RX nr below peer TX with XDP set"
> -	ip netns exec $NS_DST ethtool -L veth$DST rx 1 2>/dev/null &&\
> -		echo "fail - set operation successful ?!?" || echo " ok "
> +	if ip netns exec $NS_DST ethtool -L veth$DST rx 1 2>/dev/null; then
> +		echo "fail - set operation successful ?!?"
> +		ret=1
> +	else
> +		echo " ok "
> +	fi
>  	CUR_RX=2
>  	CUR_TX=2
>  fi
>  
>  if [ $CPUS -gt 2 ]; then
>  	printf "%-60s" "bad setting: increasing peer TX nr above RX with XDP set"
> -	ip netns exec $NS_SRC ethtool -L veth$SRC tx 3 2>/dev/null &&\
> -		echo "fail - set operation successful ?!?" || echo " ok "
> +	if ip netns exec $NS_SRC ethtool -L veth$SRC tx 3 2>/dev/null; then
> +		echo "fail - set operation successful ?!?"
> +		ret=1
> +	else
> +		echo " ok "
> +	fi
>  	chk_channels "setting invalid channels nr" $DST 2 2
>  fi
>  
> -- 
> 2.43.0
> 

This one and patch 2 are fixing the same issue in the same test. Why bother
with two patches?

Thanks
Hangbin
