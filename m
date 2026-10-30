Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793364350;
	b=bo4vjWjfOEFZpL0MZ8HpNRRUG3/zI/zHJe6XmeQQ361163ddW+SdYqX2iRvdbUcpE4WJ
	 HkwwCS2aND0qM0xZzXe6eC2xOMuKZFtX/oPGsBD/8aoQUkm0e2OcovhxULbdsX4PV3Ci1
	 0Uiyy7qXu1vUzB+pJ/GqrUVg7i0lGFQVUNENgvOuuH7GgNri30HX3paGVCuJw+yXTe2w+
	 CnUO4tTHmskHnxdsuHq/JNHId2t4ds5xZOKWJq+QhVhzDV2ePvEqPYH/85oYI+/q8nzT5
	 64GKo6vBojZcEl/YEKhg6kNM4v0sCBxjsazRsudQA9brIReZFNLnDNpJGLYW4I14rMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793364350;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=jE/d881YY3SoJyzXgCRntoSX9ott7YhMKwZ2jO4IBRU=;
	b=Yt+filxz69yott8R9GHMYgsNlLH7kW8rV8jmW9luj7j98j2MqQUcuJuC7ovXz0C+tkuA
	 XG/ULIm9kghaiRNXI3LbhA3UOtmZX9W1AUffnHZitahG9FKRdywLZo0gPC2cxQp32uNRs
	 x/twdaEdZrq5oMQ6NbeXaz1hTR5xO2UBYVe4qqaG6iNLQHXHuCeRzdw8063sz4wlwJUZ2
	 9prkJe04sziLE5f8uHau8zTRmJd/G2L8MEyKhvY/JMC5vXZvzkVSSj4OT8QLmx29npK0d
	 YzUQb6lbReOUQpiomwbVsejLyyqBThWFGrqoearJGwr4iuQnKqa7WmmC7dk7fyABkCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nzfRmEHi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8AD606A31C;
	Fri, 30 Oct 2026 12:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nzfRmEHi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 475B81F000C1;
	Fri, 30 Oct 2026 12:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793364349;
	bh=jE/d881YY3SoJyzXgCRntoSX9ott7YhMKwZ2jO4IBRU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=nzfRmEHiobLc4xrnoJ4t4GXPrPD0PbnYHdsYvmgVg2naI96o4WGSzVdxI5xUqpF1X
	 AWKDxgnYvjPkvA1nY1dvyNq74pYtKI6OIwViSOEF9DqozdMy/8YUmSzZLbqOFDOlr0
	 7F1uZJQnEQWNmI9dUbP6Oh+cWTMdzwGdub7nhcpYYWjtHV/PgoKa8ES8ODO4thG3Ev
	 W8PaL6n+IDysX0W/DC/qxUzHF4QJ39et04cBO7g9eCr2RG2lxgQodQTF7ka8YWlrP6
	 X6+T3WoGxaGk1ujPQNBfcV9pXGCQAt3Flg/8a358KJXLR32LNx6pcTMlQAQRZlvWka
	 gXHgALnrqw0zA==
Content-Type: multipart/mixed; boundary="===============5168075361254505390=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <f8deb60a9defc57ab66786255fb2e397696c9dc9a86b2c320c63494a38e97e9e@mail.kernel.org>
In-Reply-To: <20261030-bpf-next-v1-2-035eabf8eae7@cloudflare.com>
References: <20261030-bpf-next-v1-2-035eabf8eae7@cloudflare.com>
Subject: Re: [PATCH bpf-next 2/2] bpf, sockmap: Fix psock update-side data races on sk->sk_prot and progs
From: bot+bpf-ci@kernel.org
To: jakub@cloudflare.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,shuah@kernel.org,edumazet@kernel.org,kuniyu@google.com,pabeni@redhat.com,willemb@google.com,john.fastabend@gmail.com,jiayuan.chen@linux.dev,davem@davemloft.net,kuba@kernel.org,horms@kernel.org
Cc: bpf@vger.kernel.org,netdev@vger.kernel.org,kernel-team@cloudflare.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 30 Oct 2026 12:45:49 +0000 (UTC)

--===============5168075361254505390==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf, sockmap: Fix psock update-side data races on sk->sk_prot and progs

TL;DR: Commit message only: the first bullet says the saved_data_ready gating
was dropped in sock_map_link(), but the diff drops it in sock_map_del_link(),
duplicating the second bullet.

>     bpf, sockmap: Fix psock update-side data races on sk->sk_prot and progs
>
>     The update side of the sockmap psock lifecycle has several unsynchronized
>     accesses to sk->sk_prot and psock prog state that KCSAN flags when the
>     new update-vs-delete race selftest runs. The fix comes from Alexei [1]:
>
>     * sock_map_link() installed psock programs and called sock_map_init_proto()
>       before taking sk->sk_callback_lock, racing a concurrent teardown's
>       tcp_bpf_update_proto() write of sk->sk_prot. Take the write_lock early,
>       before psock_set_prog() and sock_map_init_proto(), and drop the
>       psock->saved_data_ready gating from prog detection (it is re-checked
>       under the lock before stopping progs).
>
>     * sock_map_del_link() read psock->saved_data_ready outside the lock. Move
>       the saved_data_ready check under write_lock_bh(&sk->sk_callback_lock)
>       so prog teardown is serialized against the proto restore.
>
>     * sock_map_psock_get_checked() and sock_map_sk_is_suitable() did plain
>       sk->sk_prot reads. Convert to READ_ONCE() to mark the intentional racy
>       read against the WRITE_ONCE() swap in sock_replace_proto().
>
>     With these changes the sock_map_link/psock_set_prog side of the reported
>     KCSAN splats is silenced; the remaining teardown-vs-core-TCP pairings
>     are the separate read-side annotation problem.
>
>     [1] https://lore.kernel.org/bpf/DMBHB0TQOV1L.38MECMYFGUS5B@gmail.com
>
>     Suggested-by: Alexei Starovoitov <ast@kernel.org>
>     Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>

The first bullet says sock_map_link() drops the psock->saved_data_ready
gating from prog detection, which is "re-checked under the lock before
stopping progs".  Is that sentence describing the right function?

The diff doesn't change sock_map_link() that way.  Its only change is
moving write_lock_bh(&sk->sk_callback_lock) above the psock_set_prog()
calls, plus the matching unlock on the sock_map_init_proto() error path.
sock_map_link() still gates on !psock->saved_data_ready:

    if (stream_parser && stream_verdict && !psock->saved_data_ready) {

The gating that was dropped is in sock_map_del_link():

    -	if (psock->saved_data_ready && progs->stream_parser)
    +	if (progs->stream_parser)
     		strp_stop = true;
    ...
    +	write_lock_bh(&sk->sk_callback_lock);
    +	if (psock->saved_data_ready) {

The second bullet already covers the sock_map_del_link() lock and
saved_data_ready change, so the sentence in the first bullet looks both
misplaced and repeated.

Could it be moved to (or merged with) the sock_map_del_link() bullet, so
that a reader doesn't conclude the saved_data_ready checks were removed
from sock_map_link()?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/41053761520
--===============5168075361254505390==--
