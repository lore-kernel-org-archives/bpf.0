Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794075791;
	b=eVkFcBsabfAq91hx0CMVrk9ncTMrdjyUbotnFbFVV7us+W07raCZy0T8IyfvC6Aqdnzw
	 KW6ZgLGLbPvcWH7HWuT/vZ6PRGwKWX2tmJ6Fl2Fym9R0uaKg435zcOUNtnvjtUeFnb0SJ
	 +SwPMdmgSSRTsxszZ455HXUmve1xkOiZ501OAdzd4XXTZIsX6h+162l7eGUEJHQXOXAs1
	 aGvbuV02y8gz5nZOgTYxKQbXsfnUxOOEIZfoqJMxriV79tRQAY+jyBGX4bckIKap48d7V
	 wwCxA9yc3cGPIaFlQyWF9KwspSjTaXNxcb40Vyx8kw2YJXyC8Wi7IK9E6N0dC86XItQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794075791;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Zhk2lJ5i0PD+dNx5L6T09BCXX2xebMSS8SuI9Asmbp8=;
	b=PG2GkAJ216uth/GXyRafMfxC9qb/CknHj9JVereNF3NZzjgXUYlWpAbHMIoW2n18ioMY
	 ocJQpDOkWFHqhiZVzVyvy3hIQxGIMQ22/5THNn/fUi9LFbshwJnJJjloF+MGlnC2hUVEi
	 DRDG69coeXG0nw4OGtMJ5ZXCCkKkTRXHOa6/qqiDec+9bZs4uYDSXBbKHBW6PjQgv3pHi
	 7UvzH9QWndFmSYurItva8284TWNYxJcUvybiFMut3YGRfmGqUdoUdcD9DiR+wdy6g6TZz
	 SlFJKWpMWLzAOt/CBiKnXsuxMh4PjkmWYmFeM82W/CBZjMvxcHXwhr1mQL8ENJHeciQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EH0QpnSN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8735D606A335;
	Sat,  7 Nov 2026 18:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EH0QpnSN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C6891F008A1;
	Sat,  7 Nov 2026 18:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794075791;
	bh=Zhk2lJ5i0PD+dNx5L6T09BCXX2xebMSS8SuI9Asmbp8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=EH0QpnSN1rMgDTq2OwL+3V/ZqZxtJ0UkLqnLGk9l06N5bYmEtj6l9lm6bJG1jlSQ9
	 HvWkUWOjGmmNg8t2swKiigH0dvC2arPLmOFBl2WG1sGAT8k1zhspHiMGZsqJ+9FQGW
	 7+U2vE9LQOjC4XB0HC5nyDN2wG3b6gJKbGWJwGU4f3jAVY8EJWiCYj5tPEWtwPQuSk
	 oT5KHFehzaZgcg1ESnRnyrlbwrl9hL9kASEGKgUPbFDFQzYh4DMG14Lwau2o0b/ta0
	 zN+Hp6bzeI8snXGUTuizpM2HFcR9q3EKTgcOMFySc4S18hkCAYTI266x3GcvtFU+uv
	 xUQTdfBUMKiBQ==
Subject:
 Re: [PATCH net v3 2/2] selftests/net: psp: test bidirectional data transfer
From: netdev-bot+sashiko@kernel.org
To: weiwan@google.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, shuah@kernel.org, horms@kernel.org,
 jakub@cloudflare.com, daniel.zahka@gmail.com, willemb@google.com,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Date: Sat, 07 Nov 2026 18:23:10 +0000
Message-ID: <179407579002.994134.3073388292335416483@kernel.org>
In-Reply-To: <20261106182007.374660-3-weiwan@google.com>
References: <20261106182007.374660-3-weiwan@google.com>
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

- [Low] _recv_careful() in tools/testing/selftests/drivers/net/psp.py,
  added by this patch, does not check for end-of-stream.

--

selftests/net: psp: test bidirectional data transfer

This patch makes the PSP selftests check data in both directions. The
test socket now asks psp_responder for a "data echo" and checks that the
PSP-encrypted reply arrives. The check is added to _data_basic_send() and
_data_basic_send_netkit_psp_assoc().

> diff --git a/tools/testing/selftests/drivers/net/psp.py b/tools/testing/selftests/drivers/net/psp.py
> index 473500901879b..c114d2245135b 100755
> --- a/tools/testing/selftests/drivers/net/psp.py
> +++ b/tools/testing/selftests/drivers/net/psp.py
> @@ -120,6 +120,26 @@ def _check_data_rx(cfg, exp_len):
>      ksft_eq(read_len, exp_len)
>  
>  
> +def _recv_careful(s, target, timeout=2):
> +    """Read exactly target bytes, tolerating short reads"""
> +    data = b''
> +    end = time.monotonic() + timeout
> +    while time.monotonic() < end:
> +        try:
> +            data += s.recv(target - len(data), socket.MSG_DONTWAIT)
> +            if len(data) == target:
> +                return data
> +        except BlockingIOError:
> +            time.sleep(0.001)
> +    raise KsftFailEx(f"short read, got {len(data)} of {target} bytes")

[Severity: Low]
What happens in _recv_careful() if the peer has already sent a FIN on the
data socket?

In that case s.recv(..., socket.MSG_DONTWAIT) returns b'' and does not
raise. data stays the same, the len(data) == target check stays false, and
the loop never reaches time.sleep(0.001), because the sleep is only in the
BlockingIOError branch.

So the loop calls recv() with no delay for the full 2 second timeout. It
then reports a generic "short read, got N of 5 bytes" instead of saying the
peer closed the connection.

This looks reachable. run_session() in psp_responder.c acks "data echo"
even when it has no data socket:

    if (cmd("data echo")) {
        if (data_sock >= 0)
            send(data_sock, "echo", 5, MSG_WAITALL);
        else
            fprintf(stderr, "WARN: echo but no data sock\n");
        send_ack(comm_sock);
    }

The responder can also close an established data socket on its "new data
sock but old one still here" accept path, which sends a FIN to the test
socket.

Would it make sense to check the chunk returned by recv() and raise
KsftFailEx right away, with a message like "peer closed data socket", when
it is empty?

> +
> +
> +def _req_echo(cfg, s):
> +    """Ask the peer to echo, and check the reply arrives intact"""
> +    _send_with_ack(cfg, b'data echo\0')
> +    ksft_eq(_recv_careful(s, 5), b'echo\0')

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106182007.374660-1-weiwan%40google.com
