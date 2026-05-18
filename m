Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E72F38F929
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 19:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779132642; cv=none; b=ujdJsXgu7snnbf5OI+/CWEsQmT5VNd75A+fafAWIcAb5jjQuZb/i/tcdJUJdRVWawKimt/+ZClMl3lFu/eCFLyIahb2Tq/5ToMSCpARRuI6eH0pDJ+ZXHpOcKxx3EpRgNNxT6iR5nlQ0Z9CyrmQppi0PvVPwMQknlAK/1g6f8t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779132642; c=relaxed/simple;
	bh=tno6Me3ZcOZAv6N7XqBENEZlV3f6Qc13jxNtohsnFco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MY0rMbpmTKNO/MGC/CLnVjBo6lJSHT329kwlVuqpnaIGuO38GaMg063cIkp2RvdfYgV1hb5YsUk2aAwnvfAX4a56fbjrb3j6w5ruU0qBHv8e8KmJzkD0Tpo8CHOI3WaIpbJVnJnkv6uj744QaczdUlP04I6hKx2Q5906IXLaMSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X6ob96B2; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X6ob96B2"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-82f9fdfc965so1152266b3a.1
        for <bpf@vger.kernel.org>; Mon, 18 May 2026 12:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779132640; x=1779737440; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XUAI+gcTrWzhY2kxifeTGfhNIQUbmT5Cv6qjr63MunU=;
        b=X6ob96B2Uf0RBoiROm4QZFTLXKzPkDBJ+qR/Ji6tzZCK4gn8eJLGjRnW+IVSxGWLPF
         A+4nKp9rPDbXk0UhMZJn7hZWT2N8nrVhM46YqZTnU0iKg0enkS8XEhf5s+HhKAoFFlbC
         s1ySWGeOeBKhg9293sgjr040Y30M+cTtXoW6T45F7Ht8xmKraJgrtXvX/EGrRTeU42FY
         TqzxVMVol0arnPdirZebtcm0ccE7e96Yj28ohIJK7eNCEkowKIBNBy0j6mfiFMHgr7nX
         XmIXZWqIlRrRyyTn+TW+gs6s5avVCmKfhJZvRbFsy3Ys0+AZFci/HzyLnmVucY6lSm4g
         7M/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779132640; x=1779737440;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XUAI+gcTrWzhY2kxifeTGfhNIQUbmT5Cv6qjr63MunU=;
        b=NLQf1BW7ZBVi5ZcUvGPtN+4hTg7+ljwxiNE1UpWDez5Pc8js7xAIKbBZot8SklbDnq
         s8RM5y3fj6i0GSCdV6yMLPcIWCKxhAlQKpIO/xGwH3zJwQs1Sf7pq9Q86PIgiC79JIZD
         Z2BifhzauX1jql0lZdhmyDAG+Xx3a/qFqBTXqwmIq3kNSfRNOiHfk7uh9dLKUnWUZ+c9
         2XmLfYRVlal0l9/KdVENyJ9f4SHNfyFW98w7w06/fjMlqP8+aDrxdb8CAVhiYzJQNpCp
         PO+OEknW5E9RRhHTQHa+Q04yuOYVQ6hkwEuffCvWP44GbUiAtskXEIcGXCRYA2WTY3Ds
         8uLw==
X-Forwarded-Encrypted: i=1; AFNElJ/tlvuoyzcX/DItc1a9ObDmfzt49VofHvVKsnMezndlg7168N6VR2oxdfAFA9b8oAs2OvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOYBdfvuK1feacLa7YCbxGCceEDAxdFZ1So8g6QRvz4M2j5uXJ
	s7cMsrMUcB2UPwitX0xB/nRbpIFX+3Q7NFCxWZ/kFplb9lx1OMW6K4zd
X-Gm-Gg: Acq92OHTRzm62LIweXFY80C5bGf5thSJG0IW2r34MaUYWVtSKJOb+2nBi6lN8eMCG0S
	O+s+jEr8cnqcX9boM586fKPTxIYEs2ZjpbXtXagExL76y+eFW86+VTRH5Nv2vdf7dkIZ7WGvX8s
	VkP/kwXwIHSxBRND/WbSOZxXYp37TTfE0VzvldyMNuXdVJ4votcN8eEV9EfcipB7RxzTAnxTAVB
	9Ui+iEP+7n4PR17CqDS2pQK+eEoQKvNyHQj1YE77D9KBV2J4+7JYwAYg7t1zo7sMk4CNhHCSueP
	sYX1Qa93/U8UB5sWmxcvstqk016JhLP9OZ1wxjsNkvnoL5j6VlJtZ/gzOGnQxHoaHyAUsbeKqjs
	5N2eZiu/jwqmmzBtg+yYdvbAVW4HyKcvQrbpTro8L5PlGfHSNNhq5+YzEUre5TF08CKShfaEUyr
	u9CNttjC4wAel+uLlPwIGf
X-Received: by 2002:a05:6a00:4ac2:b0:82f:1b1b:e166 with SMTP id d2e1a72fcca58-83f33d5851fmr16245374b3a.33.1779132639627;
        Mon, 18 May 2026 12:30:39 -0700 (PDT)
Received: from john-p8 ([98.97.42.187])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19c5b71fsm14295643b3a.29.2026.05.18.12.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 12:30:37 -0700 (PDT)
Date: Mon, 18 May 2026 12:30:35 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Zhang Cen <rollkingzzc@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, 
	Jakub Sitnicki <jakub@cloudflare.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, zerocling0077@gmail.com, 
	2045gemini@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH] bpf, sockmap: keep sk_msg copy state in sync
Message-ID: <xubhldxd3kufb4hcmcda7gg753gbfzw3ftcr3k6texs3dw24az@7ct6rrstfpsr>
References: <20260516164319.1519418-1-rollkingzzc@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260516164319.1519418-1-rollkingzzc@gmail.com>

On Sun, May 17, 2026 at 12:43:19AM +0800, Zhang Cen wrote:
>SK_MSG helpers use msg->sg.copy as provenance for scatterlist entries that
>still refer to external or shared pages and must not be exposed through
>data/data_end.
>
>bpf_msg_pull_data(), bpf_msg_push_data() and bpf_msg_pop_data() rewrite the
>scatterlist ring by compacting, splitting and shifting entries. Those
>updates move msg->sg.data[] slots around, but leave the parallel copy
>bitmap behind.
>A later helper sequence can then move an external entry back to
>msg->sg.start with its copy bit cleared and make
>sk_msg_compute_data_pointers() treat it as directly writable packet data.
>
>Keep msg->sg.copy synchronized with every scatterlist move, preserve
>the bit for split tail entries, and clear it whenever a helper replaces
>an entry with a freshly allocated private page.
>
>Fixes: 015632bb30da ("bpf: sk_msg program helper bpf_sk_msg_pull_data")
>Fixes: 6fff607e2f14 ("bpf: sk_msg program helper bpf_msg_push_data")
>Fixes: 7246d8ed4dcc ("bpf: helper to pop data from messages")
>Cc: stable@vger.kernel.org
>Co-developed-by: Han Guidong <2045gemini@gmail.com>
>Signed-off-by: Han Guidong <2045gemini@gmail.com>
>Signed-off-by: Zhang Cen <rollkingzzc@gmail.com>
>---
>While researching recent page cache bugs, we discovered this bug. We confirmed it allows overwriting the page cache of read-only files via splice(). We haven't attempted to write an exploit, but the corruption primitive is verified. PoC available upon request. Recommend fixing ASAP.
>---

Important note here is it requires a BPF skmsg program that is using
the push/pull/pop API calls correct? Agree its not great we should
fix, but the scope is limited to just this set of users.

> net/core/filter.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++-
> 1 file changed, 49 insertions(+), 1 deletion(-)

fwiw I also found this looking at things last Friday. Seems tools
are good at finding this.

>
>diff --git a/net/core/filter.c b/net/core/filter.c
>index 9590877b0714f..352233da29429 100644
>--- a/net/core/filter.c
>+++ b/net/core/filter.c
>@@ -2654,6 +2654,19 @@ static void sk_msg_reset_curr(struct sk_msg *msg)
> 	}
> }
>
>+static bool sk_msg_elem_is_copy(const struct sk_msg *msg, u32 i)
>+{
>+	return test_bit(i, msg->sg.copy);
>+}
>+
>+static void sk_msg_set_elem_copy(struct sk_msg *msg, u32 i, bool copy)
>+{
>+	if (copy)
>+		__set_bit(i, msg->sg.copy);
>+	else
>+		__clear_bit(i, msg->sg.copy);
>+}
>+
> static const struct bpf_func_proto bpf_msg_cork_bytes_proto = {
> 	.func           = bpf_msg_cork_bytes,
> 	.gpl_only       = false,
>@@ -2738,6 +2751,8 @@ BPF_CALL_4(bpf_msg_pull_data, struct sk_msg *, msg, u32, start,
> 	} while (i != last_sge);
>
> 	sg_set_page(&msg->sg.data[first_sge], page, copy, 0);
>+	sk_msg_set_elem_copy(msg, first_sge, false);
>+	sk_msg_set_elem_copy(msg, msg->sg.end, false);

The sg.end is cleared at the end of the msg_pull_data() already correct?

>
> 	/* To repair sg ring we need to shift entries. If we only
> 	 * had a single entry though we can just replace it and
>@@ -2754,6 +2769,7 @@ BPF_CALL_4(bpf_msg_pull_data, struct sk_msg *, msg, u32, start,
> 	sk_msg_iter_var_next(i);
> 	do {
> 		u32 move_from;
>+		bool move_copy;
>
> 		if (i + shift >= NR_MSG_FRAG_IDS)
> 			move_from = i + shift - NR_MSG_FRAG_IDS;
>@@ -2762,10 +2778,13 @@ BPF_CALL_4(bpf_msg_pull_data, struct sk_msg *, msg, u32, start,
> 		if (move_from == msg->sg.end)
> 			break;
>
>+		move_copy = sk_msg_elem_is_copy(msg, move_from);
> 		msg->sg.data[i] = msg->sg.data[move_from];
>+		sk_msg_set_elem_copy(msg, i, move_copy);

This block is open coded sk_msg_sg_move()?

> 		msg->sg.data[move_from].length = 0;
> 		msg->sg.data[move_from].page_link = 0;
> 		msg->sg.data[move_from].offset = 0;
>+		sk_msg_set_elem_copy(msg, move_from, false);

+1.

> 		sk_msg_iter_var_next(i);
> 	} while (1);
>
>@@ -2794,6 +2813,8 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
> {
> 	struct scatterlist sge, nsge, nnsge, rsge = {0}, *psge;
> 	u32 new, i = 0, l = 0, space, copy = 0, offset = 0;
>+	bool sge_copy = false, nsge_copy = false, nnsge_copy = false;
>+	bool rsge_copy = false;
> 	u8 *raw, *to, *from;
> 	struct page *page;
>
>@@ -2866,6 +2887,7 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
> 			sk_msg_iter_var_prev(i);
> 		psge = sk_msg_elem(msg, i);
> 		rsge = sk_msg_elem_cpy(msg, i);
>+		rsge_copy = sk_msg_elem_is_copy(msg, i);
>
> 		psge->length = start - offset;
> 		rsge.length -= psge->length;
>@@ -2891,23 +2913,31 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
> 	/* Shift one or two slots as needed */
> 	sge = sk_msg_elem_cpy(msg, new);
> 	sg_unmark_end(&sge);
>+	sge_copy = sk_msg_elem_is_copy(msg, new);
>

There is another bug here, maybe arguably not the same issue as the
copy bit handling.

@@ -2857,10 +2870,11 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, st
art,
		sk_msg_iter_var_prev(i);
                 psge = sk_msg_elem(msg, i);
                 rsge = sk_msg_elem_cpy(msg, i);
+               rsge_copy = test_bit(i, msg->sg.copy);

                 psge->length = start - offset;
                 rsge.length -= psge->length;
-               rsge.offset += start;
+               rsge.offset += start - offset;


> 	nsge = sk_msg_elem_cpy(msg, i);
>+	nsge_copy = sk_msg_elem_is_copy(msg, i);
> 	if (rsge.length) {
> 		sk_msg_iter_var_next(i);
> 		nnsge = sk_msg_elem_cpy(msg, i);
>+		nnsge_copy = sk_msg_elem_is_copy(msg, i);
> 		sk_msg_iter_next(msg, end);
> 	}
>
> 	while (i != msg->sg.end) {
> 		msg->sg.data[i] = sge;
>+		sk_msg_set_elem_copy(msg, i, sge_copy);
> 		sge = nsge;
>+		sge_copy = nsge_copy;
> 		sk_msg_iter_var_next(i);
> 		if (rsge.length) {
> 			nsge = nnsge;
>+			nsge_copy = nnsge_copy;
> 			nnsge = sk_msg_elem_cpy(msg, i);
>+			nnsge_copy = sk_msg_elem_is_copy(msg, i);
> 		} else {
> 			nsge = sk_msg_elem_cpy(msg, i);
>+			nsge_copy = sk_msg_elem_is_copy(msg, i);
> 		}
> 	}
>
>@@ -2915,13 +2945,15 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
> 	/* Place newly allocated data buffer */
> 	sk_mem_charge(msg->sk, len);
> 	msg->sg.size += len;
>-	__clear_bit(new, msg->sg.copy);
>+	sk_msg_set_elem_copy(msg, new, false);
> 	sg_set_page(&msg->sg.data[new], page, len + copy, 0);
> 	if (rsge.length) {
> 		get_page(sg_page(&rsge));
> 		sk_msg_iter_var_next(new);
> 		msg->sg.data[new] = rsge;
>+		sk_msg_set_elem_copy(msg, new, rsge_copy);
> 	}
>+	sk_msg_set_elem_copy(msg, msg->sg.end, false);

Is this sk_msg_sel_elem_copy() needed? I'll need to study a bit
more to be sure, but I don't have it on my similar patch so at
least Friday I didn't think it was necessary.

>
> 	sk_msg_reset_curr(msg);
> 	sk_msg_compute_data_pointers(msg);
>@@ -2945,29 +2977,41 @@ static void sk_msg_shift_left(struct sk_msg *msg, int i)
>
> 	put_page(sg_page(sge));
> 	do {
>+		bool copy;
>+
> 		prev = i;
> 		sk_msg_iter_var_next(i);
>+		copy = sk_msg_elem_is_copy(msg, i);
> 		msg->sg.data[prev] = msg->sg.data[i];
>+		sk_msg_set_elem_copy(msg, prev, copy);

sk_msg_sg_move()

> 	} while (i != msg->sg.end);
>
> 	sk_msg_iter_prev(msg, end);
>+	sk_msg_set_elem_copy(msg, msg->sg.end, false);
> }
>
> static void sk_msg_shift_right(struct sk_msg *msg, int i)
> {
> 	struct scatterlist tmp, sge;
>+	bool tmp_copy, sge_copy;
>
> 	sk_msg_iter_next(msg, end);
> 	sge = sk_msg_elem_cpy(msg, i);
>+	sge_copy = sk_msg_elem_is_copy(msg, i);
> 	sk_msg_iter_var_next(i);
> 	tmp = sk_msg_elem_cpy(msg, i);
>+	tmp_copy = sk_msg_elem_is_copy(msg, i);
>
> 	while (i != msg->sg.end) {
> 		msg->sg.data[i] = sge;
>+		sk_msg_set_elem_copy(msg, i, sge_copy);
> 		sk_msg_iter_var_next(i);
> 		sge = tmp;
>+		sge_copy = tmp_copy;
> 		tmp = sk_msg_elem_cpy(msg, i);
>+		tmp_copy = sk_msg_elem_is_copy(msg, i);
> 	}
>+	sk_msg_set_elem_copy(msg, msg->sg.end, false);

style nit. There is a lot of

   sk_msg_set-elem_copy(..., false);

can we just have a helper

   sk_msg_clear_elem_copy(msg, msg->sg.end)

it will be slightly nicer to read.

> }
>
> BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg, u32, start,
>@@ -3024,8 +3068,10 @@ BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg, u32, start,
> 	 */
> 	if (start != offset) {
> 		struct scatterlist *nsge, *sge = sk_msg_elem(msg, i);
>+		u32 sge_idx = i;
> 		int a = start - offset;
> 		int b = sge->length - pop - a;
>+		bool sge_copy = sk_msg_elem_is_copy(msg, sge_idx);
>
> 		sk_msg_iter_var_next(i);
>
>@@ -3038,6 +3084,7 @@ BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg, u32, start,
> 				sg_set_page(nsge,
> 					    sg_page(sge),
> 					    b, sge->offset + pop + a);
>+				sk_msg_set_elem_copy(msg, i, sge_copy);
> 			} else {
> 				struct page *page, *orig;
> 				u8 *to, *from;
>@@ -3054,6 +3101,7 @@ BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg, u32, start,
> 				memcpy(to, from, a);
> 				memcpy(to + a, from + a + pop, b);
> 				sg_set_page(sge, page, a + b, 0);
>+				sk_msg_set_elem_copy(msg, sge_idx, false);
> 				put_page(orig);
> 			}
> 			pop = 0;

Otherwise, my initial read is this is good. Can you make the small 
updates and I'll think a bit more about it in the meantime. The sashiko
commentary is good will investigate but I don't think it blocks this
patch.
