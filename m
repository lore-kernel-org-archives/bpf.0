Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795406358;
	b=o2M37BrkDNX+ANfqKPjIOgF5m1DWN2sRMVve/DD6zeuAnZWWxOpjUs1iyj/+xB4kRQn1
	 FoZVLg3WXw+x0CO/vtgR4O+m4e22e4eSnQb7SSj304g9T6jabPTODuOX75H1a8tIelYxk
	 71w69cwokrU2VYZZzlD/mlMY+dbAl2urfUzERnt2kMl8Kp/j0yIYi+e1jngi0dUUHykLM
	 tkWn3tFjvWGaHBpG0j+uBm863SpaVgXNOHITmuX4ObOzw2TN+1OwNOKQXVnuWIDZQbafY
	 EHOXcgX8/Mx90ERCbnjg3Zg8tALs8guizp3g0d9qdxqjWL6vfDrwSSRmVOnrpFpYu+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795406358;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=u+5J9OiJJ+LZk35JnLQMdA67/3OC8obSeyDezikvUJs=;
	b=q9AyD2xyL0oOXNyRG4DSTh4DS5oRrWsf0x1fE4OYLNQRT8517vH5h4f9n0jiHK9wuOui
	 B9Y8FnkSg6rmpq1ZqSaPVrt8tg0S7u4BDowAbP7qR4ZhGJF/tkM+oWK2+AXxi0hkb+qei
	 doOQJA4QjpP+Bb2ONvHlWXRTPi5H/gC/9QmsrdCz6N0ixSbqfeEtvFWKBp6DwLm4Os8R6
	 O034UAVGs3LIspvPxq0LoTJfmA9ueU+P4eZ9u/jFcIMQ0RnGONjTw8rmLvhMVpQp9MgwA
	 oYkdGt0zLn9joK1hmUmHpc8RWTsbcu8L3vQ10ocL0j69yIa2IOjIye3PYpF8G+iGbkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HTPUWbEF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D96606A32C;
	Mon, 23 Nov 2026 03:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HTPUWbEF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C39731F000C0;
	Mon, 23 Nov 2026 03:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795406357;
	bh=u+5J9OiJJ+LZk35JnLQMdA67/3OC8obSeyDezikvUJs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HTPUWbEFrKN0jQGqYEvTF+xJx5j+KBJonTZiSzSxNsyXn5uIoF2RRpMWUYTcx+7fB
	 cGmMhMmocYRpiahclzJs9tHYrmieQBonq+gJtBFSuLB1jwjlsf4bKxhPS0rgK4hud4
	 Xdn8Cem+u5/kylxxKbVSZ1KQ26zb5+Gyq6VwAsos/UW5Vqu1TdBg73P4q7IwvdwBKO
	 JwZMPqR8T2niDwZayPrFvaCbp5oZsTW9jlVsAYruTGwcqxLgB3rt1wVQ1Q9+P1c21i
	 Rw5slJ+YPzb63z0aw3kZGEyfjM0k6h2EaaDlyJbW1UMCv4bjyi4DJGYjh/QeYIZNLE
	 dxgSK0lqY4Zeg==
Subject: Re: [PATCH net-next v2 04/11] selftests: net: add flag to send a
 frame in xdp_helper
From: netdev-bot+sashiko@kernel.org
To: tianyi@cloudflare.com
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, davem@davemloft.net, horms@kernel.org, dkeogh@amazon.com,
 hawk@kernel.org, daniel@iogearbox.net, dwmw2@infradead.org,
 dtatulea@nvidia.com, noren@nvidia.com, alasdair@mcwilliam.dev,
 willemdebruijn.kernel@gmail.com, maciej.fijalkowski@intel.com,
 sdf@fomichev.me, magnus.karlsson@intel.com, dsahern@kernel.org,
 idosch@nvidia.com, ast@kernel.org, john.fastabend@gmail.com,
 donald.hunter@gmail.com, andrew+netdev@lunn.ch, corbet@lwn.net,
 skhan@linuxfoundation.org, shuah@kernel.org, rdunlap@infradead.org,
 leitao@debian.org, ast@fiberby.net, danieller@nvidia.com, kuniyu@google.com,
 bpf@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-team@cloudflare.com,
 nh-open-source@amazon.com, stephen@networkplumber.org, gustavoars@kernel.org,
 one-d-wide@protonmail.com, ameryhung@gmail.com, andrii@kernel.org,
 aroulin@nvidia.com, anilkaushikwireless@gmail.com, demosthenes.ra@gmail.com,
 eddyz87@gmail.com, emil@etsalapatis.com, hangbin.liu@linux.dev,
 ihor.solodrai@linux.dev, jiayuan.chen@linux.dev, jolsa@kernel.org,
 joe@dama.to, memxor@gmail.com, lirongqing@baidu.com, louis.scalbert@6wind.com,
 mkl@pengutronix.de, martin.lau@linux.dev, mkarsten@uwaterloo.ca,
 mattbobrowski@google.com, michael.bommarito@gmail.com, razor@blackwall.org,
 runyu.xiao@seu.edu.cn, song@kernel.org, linux@leemhuis.info,
 wang.zhan@smartx.com, yonghong.song@linux.dev, n0ps1edzz@gmail.com,
 tianyi.gao@linux.dev
Date: Mon, 23 Nov 2026 03:59:13 +0000
Message-ID: <179540635338.3135.16458005376139253755@kernel.org>
In-Reply-To: <20261119013830.36935-5-tianyi@cloudflare.com>
References: <20261119013830.36935-5-tianyi@cloudflare.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message says the new -t option is "meant for copy
  mode", because a zerocopy driver "may send it later".
- [Low] The concern says nothing in the tree uses the new -t option of
  xdp_helper, so the option is dead code and the AF_XDP copy-mode…
- [Low] parse_frame() in tools/testing/selftests/net/lib/xdp_helper.c
  checks each byte only through the return value of sscanf(hex + 2 * i,…

--

selftests: net: add flag to send a frame in xdp_helper

This adds a -t option to xdp_helper. The option takes one Ethernet frame
in hex, creates a TX ring, posts a single descriptor, kicks the socket
with sendto() and exits. Without -t the helper behaves as before.

> diff --git a/tools/testing/selftests/net/lib/xdp_helper.c b/tools/testing/selftests/net/lib/xdp_helper.c
> index eb025a9f35b18..1111631efd73b 100644
> --- a/tools/testing/selftests/net/lib/xdp_helper.c
> +++ b/tools/testing/selftests/net/lib/xdp_helper.c
> @@ -19,15 +19,65 @@

[ ... ]

> +static int parse_frame(unsigned char *buf, const char *hex)
> +{
> +	size_t len = strlen(hex) / 2;
> +	size_t i;
> +
> +	if (!len || len > 2048 || strlen(hex) % 2)
> +		return -1;
> +	for (i = 0; i < len; i++)
> +		if (sscanf(hex + 2 * i, "%2hhx", &buf[i]) != 1)
> +			return -1;

[Severity: Low]
Is the sscanf() return value strict enough to validate each byte in
parse_frame()?

The %x conversion skips leading whitespace, accepts an optional +/- sign,
and succeeds after a single hex digit. So "0g" is parsed as 0x00 and "-1"
as 0xff.

" f" reads into the next pair, because whitespace does not count toward
the width but the loop always moves forward by 2.

This means parse_frame() can return a positive length for input that is
not strict hex. The only caller later in the series, _send_xsk() in
tx_extra_headroom.py, passes bytes.hex() output. The commit message also
says -t takes one well-formed frame, so this only matters for malformed
command line input.

Would an isxdigit() check on both characters of each pair be worth adding?

> +	return len;
> +}

[ ... ]

> @@ -94,9 +146,20 @@ int main(int argc, char **argv)
>  	sxdp.sxdp_queue_id = queue;
>  	sxdp.sxdp_flags = 0;
>  
> -	if (argc > 3) {
> -		if (!strcmp(argv[3], "-z")) {
> +	for (i = 3; i < argc; i++) {
> +		if (!strcmp(argv[i], "-z")) {
>  			sxdp.sxdp_flags = XDP_ZEROCOPY;
> +		} else if (!strcmp(argv[i], "-t") && i + 1 < argc) {

[Severity: Low]
The commit message says:

  "A driver with zerocopy support may send it later, so -t is meant for
  copy mode."

Is this restriction enforced anywhere? With -t and no -z, sxdp_flags
stays 0. This loop also accepts -z together with -t, which sets
XDP_ZEROCOPY.

With flags == 0, xp_assign_dev() tries zerocopy first. It only uses copy
mode when the driver lacks support:

net/xdp/xsk_buff_pool.c:xp_assign_dev() {
    ...
	if (force_copy)
		/* For copy-mode, we are done. */
		return 0;

	if ((netdev->xdp_features & NETDEV_XDP_ACT_XSK) != NETDEV_XDP_ACT_XSK) {
    ...
}

On a zerocopy socket, __xsk_sendmsg() only wakes the driver and does not
transmit anything inside the syscall:

net/xdp/xsk.c:__xsk_sendmsg() {
    ...
	if (pool->cached_need_wakeup & XDP_WAKEUP_TX) {
		if (xs->zc)
			return xsk_wakeup(xs, XDP_WAKEUP_TX);
		return xsk_generic_xmit(sk);
	}
    ...
}

send_frame() treats a successful sendto() as the frame having been sent.
main() then returns right away, so process exit closes the socket and
tears down the pool. Nothing checks the completion ring.

On a zerocopy-capable NIC, can the helper exit with status 0 even though
the frame was never sent? veth stays in copy mode, so tx_extra_headroom.py
later in the series is not affected. However, xdp_helper is shared with
queues.py and xsk_reconfig.py, which run on real hardware.

print_usage() shows "[-z] [-t frame_hex]" and "send one frame, given in
hex, and exit". The header comment says "with -t it sends one frame
through the TX ring and exits". Neither mentions the copy mode limit.

Could -t set XDP_COPY and reject -z, or could the usage text at least
document the limit?

> +			frame_len = parse_frame(umem_area, argv[++i]);
> +			if (frame_len < 0) {
> +				print_usage(argv[0]);
> +				return 1;
> +			}

[ ... ]

> @@ -119,6 +182,9 @@ int main(int argc, char **argv)
>  		}
>  	}
>  
> +	if (frame_len)
> +		return send_frame(sock_fd, frame_len);
> +

[Severity: Low]
Nothing in this patch uses the new -t option, so by itself the patch adds
no test coverage for the AF_XDP copy mode TX path.

This seems to be handled later in the series. The patch "selftests: net:
add tx_extra_headroom test" adds tx_extra_headroom.py, whose _send_xsk()
runs this on veth0:

    cmd(f"{XDP_HELPER} {ifindex} 0 -t {_eth_frame().hex()}")

That patch also updates the xdp_helper.c header comment to list
tx_extra_headroom.py as a user.

Is this split across the two patches intended?

>  	ksft_ready();
>  	ksft_wait();
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261119013830.36935-1-tianyi%40cloudflare.com
