Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CCB3D5C23;
	Wed,  5 Aug 2026 20:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785960897; cv=none; b=TLE4D4DYRAC2Lq42IO3phFd2TPwJneBR5a1aXOE3ivGc4rQHeg2c8wraux+ummaMDnEo/A3AoK7DCxO77RsjpgPOQqwhbSWT6el3HAoiXtVtguXlJKElShKtev6GK8j8JNG4LeRrqDXH2W/K+KsSF1Rx5NIzxteoHNM901HwSGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785960897; c=relaxed/simple;
	bh=BMThjoAYDTeWGcNUujjwAllp9ypGc9QAeJGFtN4FZd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RKFwBOkwmZ+UCXy+k4yBb5XuBLBopnO0Pvu5ZgPGBqfyHoylA6wgsqUQmix0aUUIn8dEyFMQB0wsseTcSfe6/R1tCuvM3Mdo6LJT289ftWx1jSeh9lDoAJ82PAm97gateVCBHAqV+0n5J0KHNZxKbAZMlp8mB8hUhnnViKCeNLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=fWfOHVwL; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="fWfOHVwL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=YpIqTsGhrVZStEDj0hFgiKU/C0c7jnBOwQf802PkiK4=; b=fWfOHVwLHVC+NUYUTEwyOos3I+
	kP9OJpDsZiQ+q7dyBxHfxCnbbl8KbTbRPfqqGHqbfabJ/4k3QB1Wyz/C2tammXoUmtOZL/o9FKjzy
	EZQ7yBmW+gDyPjQ4hNzlTzWTuWNTW5mjx19Yl6HglDiyuAj5Y5Sw0gA16x3LY5XuyclfzMW/OI83X
	aKxSheJySt2hlO9ywSBGos+EJiOjAXGonmG1qa/yl+g0c0+eOZtegmGpAWC1YP0Ob+4U9ytlevrHj
	qFkv4xpfmErfowDNezhHjPYSDHngwqgVyVKFMLdxI6PCHvWLYa9RfLEr2sZhUUI+ls4eSFovURDXs
	stQCRSwQ==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wri0p-00083U-1U;
	Wed, 05 Aug 2026 22:14:51 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy04.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1wri0o-000FOZ-1e;
	Wed, 05 Aug 2026 22:14:50 +0200
Message-ID: <e7ab30a7-64c6-4497-8a9f-9b991d9f45f7@iogearbox.net>
Date: Wed, 5 Aug 2026 22:14:49 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] lwt_bpf: account for aligned neigh header length
To: Junseo Lim <zirajs7@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 Martin KaFai Lau <martin.lau@kernel.org>, Leon Hwang <leon.hwang@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Guillaume Nault <gnault@redhat.com>,
 Fernando Fernandez Mancera <fmancera@suse.de>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Graf <tgraf@suug.ch>, Sechang Lim <rhkrqnwk98@gmail.com>
References: <20260727103005.897983-1-zirajs7@gmail.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <20260727103005.897983-1-zirajs7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28083/Wed Aug  5 08:24:50 2026)

On 7/27/26 12:30 PM, Junseo Lim wrote:
> ip_finish_output2() expands an skb to LL_RESERVED_SPACE(dev) before LWT
> xmit. An LWT_XMIT BPF program can then modify the skb head and still
> return BPF_OK, so bpf_xmit() rechecks the remaining headroom before the
> skb continues to neighbour output.
> 
> That recheck uses dst->dev->hard_header_len. This is not enough for the
> neighbour cached-header path: neigh_hh_output() copies the cached hardware
> header using the aligned hh_cache size, HH_DATA_MOD for short headers or
> HH_DATA_ALIGN(hh_len) otherwise.
> 
> On Ethernet, hard_header_len is 14 but the cached copy needs 16 bytes. If
> an LWT_XMIT BPF program calls bpf_skb_change_head(skb, 1, 0), the skb can
> still have 15 bytes of headroom after the program. xmit_check_hhlen()
> accepts that, after which neigh_hh_output() hits its headroom warning and
> drops the skb.
> 
> Compare against the aligned hardware header length in xmit_check_hhlen()
> so the BPF_OK path leaves enough headroom for neigh_hh_output()'s cached
> header copy.
> 
> Fixes: 3a0af8fd61f9 ("bpf: BPF for lightweight tunnel infrastructure")
> Signed-off-by: Junseo Lim <zirajs7@gmail.com>
> ---
> Tested on a veth pair with an LWT_XMIT program calling
> bpf_skb_change_head(skb, 1, 0). Before the patch, a UDP packet sent by
> the reproducer triggers the neigh_hh_output() warning and is dropped.
> With the patch, the packet is delivered without the warning.
> 
> Below is an excerpt of the warning before the patch:
> 
>      WARNING: ./include/net/neighbour.h:538 at ip_finish_output2+0x19f0/0x1f80, CPU#0: lwt_xmit_headro/55
>      Call Trace:
>       __ip_finish_output+0x59b/0x8b0
>       ip_finish_output+0x67/0x390
>       ip_output+0x1db/0x700
>       ip_send_skb+0x1f6/0x270
>       udp_send_skb+0x8d2/0xe00
>       udp_sendmsg+0x1717/0x2620
>       __sys_sendto+0x443/0x4e0
> 
>   net/core/lwt_bpf.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
> index bf588f508b79..2890aa59a3a0 100644
> --- a/net/core/lwt_bpf.c
> +++ b/net/core/lwt_bpf.c
> @@ -169,8 +169,10 @@ static int bpf_output(struct net *net, struct sock *sk, struct sk_buff *skb)
>   
>   static int xmit_check_hhlen(struct sk_buff *skb, int hh_len)
>   {
> -	if (skb_headroom(skb) < hh_len) {
> -		int nhead = HH_DATA_ALIGN(hh_len - skb_headroom(skb));
> +	int hh_alen = HH_DATA_ALIGN(hh_len);
> +
> +	if (skb_headroom(skb) < hh_alen) {
> +		int nhead = HH_DATA_ALIGN(hh_alen - skb_headroom(skb));
>   
>   		if (pskb_expand_head(skb, nhead, 0, GFP_ATOMIC))
>   			return -ENOMEM;

If we'd go with sth like the below, then it would also take the
dev->needed_headroom into account for the dst->dev :

diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
index bf588f508b79..bfd06b5f73b3 100644
--- a/net/core/lwt_bpf.c
+++ b/net/core/lwt_bpf.c
@@ -167,10 +167,10 @@ static int bpf_output(struct net *net, struct sock *sk, struct sk_buff *skb)
  	return dst->lwtstate->orig_output(net, sk, skb);
  }
  
-static int xmit_check_hhlen(struct sk_buff *skb, int hh_len)
+static int xmit_check_headroom(struct sk_buff *skb, int hroom)
  {
-	if (skb_headroom(skb) < hh_len) {
-		int nhead = HH_DATA_ALIGN(hh_len - skb_headroom(skb));
+	if (skb_headroom(skb) < hroom) {
+		int nhead = hroom - skb_headroom(skb);
  
  		if (pskb_expand_head(skb, nhead, 0, GFP_ATOMIC))
  			return -ENOMEM;
@@ -280,7 +280,7 @@ static int bpf_xmit(struct sk_buff *skb)
  
  	bpf = bpf_lwt_lwtunnel(dst->lwtstate);
  	if (bpf->xmit.prog) {
-		int hh_len = dst->dev->hard_header_len;
+		int hroom = LL_RESERVED_SPACE(dst->dev);
  		__be16 proto = skb->protocol;
  		int ret;
  
@@ -296,9 +296,13 @@ static int bpf_xmit(struct sk_buff *skb)
  				return -EINVAL;
  			}
  			/* If the header was expanded, headroom might be too
-			 * small for L2 header to come, expand as needed.
+			 * small for the L2 header to come, expand as needed.
+			 * neigh_hh_output() copies the cached header in
+			 * HH_DATA_MOD aligned chunks,
