Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794614856;
	b=0Ayd+OQcLSENSJ9KnSC+/9AnOawplNNLiuM0GC3x+SWYOOGbHQz8uCviacTcehMClgLW
	 q8z9yLgl+fo74HqENOMRDiaF7EQl3YjmM/KgCc3p9YiVVHZM3qGdHxbAtFwaz7ZesdJd+
	 tFqJud41ewG71mWxOTzcfbsnrfL5kveqtn8HZYXllsRfIz4P2CkgI9xNhAUj4J/2ulNW1
	 +VVfi1cfKercKWrYprPo2dNjBr/wg+hy1nDxJjSdzp9acgPJB9ePOTMOFS6puXk4jEASe
	 24Ctr9e6UG7ljBrCRT4syvuC/IYvjzyNNqxJFcUVB6zVWLDOE0PcUVFBq9Ju2NlzIvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794614856;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=b6U5I6WGd04TOOZYF69Ga7lavm1b5baZdRoxwk158uo=;
	b=RaO/Iq2G62sq6PjONSIpTzVDcoXqb0OpVCafLrxDo5qelB/PxfNBLm9nLUI1DEhSXnDj
	 fK5V3Q2XfgFDllbndVHNP62ZO/ZRTO+APOqYAP1LbdkNvLcxSwO9yxktiCMMSxEEAHMsi
	 8uH9Do4dZ1uCbDfk0Ut1Mnip9k+YvtBfVsi+oo8J+I1m/KHI6BfuctII9Q9SS2OMFOVa1
	 Lb4dhy5EABsPySsMybrDvIJIZrsnMJ9/Z6YZwHqjlC1znY4Lt8zil2ae0pCq3VWB4zP0N
	 1AKJtyytb8M0R0NIxoo1CEuTi82Oy6n+sE4DrtkZkG54/bPNEwpM9LY5+qm3REuUahg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=imnJvcYC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9AE606A327;
	Sat, 14 Nov 2026 00:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=imnJvcYC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B105F1F000C4;
	Sat, 14 Nov 2026 00:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794614856;
	bh=b6U5I6WGd04TOOZYF69Ga7lavm1b5baZdRoxwk158uo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=imnJvcYCGGlCcjlqWK/YJU8ezaFniKNPKeKyGaZkdIhaB88ZsyQBnAxjHS6eUXZY+
	 +vJKZG/HN6y7sCMJ5i+rMpjvneePSAuZEYEgb0zg4straRy0mBTmzzY2aYpRJb8Ua0
	 5qjOpy1swYoSVfk7U06FwWeAziIhnBNCNSeItRBBsP8C2cyW8DhaV2GwDzzAaNxdi/
	 5GiNSTEWzUytHoFcCITf+L9wcLouuHzQQbIrbkyeN2Yxxh3MddO2uAlWY3Keq5YuHY
	 50vNVKlNSvmYexwhN4E4oV1Wbz6hlUdO5uOXlIQy2/6Reh/xpIaPAOLgtXKQLYiPVG
	 sMrwq9ncC0EtQ==
Date: Fri, 13 Nov 2026 16:07:35 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 jv@jvosburgh.net, haiyangz@microsoft.com, ast@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, bpf@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 1/5] net: don't safety-check device features
 for XDP uninstall
Message-ID: <20261113160735.4502de4b@kernel.org>
In-Reply-To: <179461399476.2199510.18058765948144630080@kernel.org>
References: <20261112235027.4072149-2-kuba@kernel.org>
	<179461399476.2199510.18058765948144630080@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Nov 2026 23:53:14 +0000 netdev-bot+sashiko@kernel.org wrote:
> Is this really only a cleanup? It looks like it also fixes an XDP
> uninstall failure that can be hit in the current tree.

TBH it's been a while since I wrote this commit so I could be
misremembering, but IIRC what I mean to say in the commit msg is that 
I wrote the patch because the shape of the code was annoying me. 
There _may_ be some cases where we already got into bad state which
this fixes. But fixing any specific case wasn't what made me write 
the patch. (And the whole XDP prog state got desynced area has too
many bugs to claim this moves the needle).
