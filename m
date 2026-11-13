Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794575142;
	b=G25FJlXX2sdk15WC/qFQIOJKaSPm7tss9CChI4+z1nvv5/TG2fncnAIA7a/nOFTPc8Zv
	 vaokVd9Ie3IhkiLBHmvUL6qFpeSuJSU0qFkYwsQhv/PsnYYSSROEql8dDl7QP42TKJJUg
	 BhsboSnlAnlUqXohNsaayEbpAVBsC1IeELx+5C+r/cZeYWwanUKeBbpcqe9hAtIILtmv7
	 YsncLGNGxA6w/WX2eSyTUBaO6jN++Sg/DXiRhCToXXceAX8/7HLi74DvXFwtvnNqhDSZw
	 38IaHBzW++HkNRT4PIiVG5DK+it9hNm2fKrtQDUBmoGz8Ver2NdiifzrnCxLaCoiHeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794575142;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=v4TApKQ2t0hyQZxEXCOTGwfQDcbqzJhHn9ZrRsucxAk=;
	b=i6EMRfVcH0jQJYHBzLp0t87xBIlDbvq/MpPefwE7BnXWiuqJWdh4aSSXsSci4FhzT5Fz
	 4D4AVx5MeAZeoMC8R2r1Ew8YivTMimFU0jAAE1oS79jRAreHFDEJlyh6IdooUUTNbIlHF
	 MdimtsK71lhp0v3c9i7OVYy++X7X6cBQu4AWExx/s6+i9dpRiWG7QRPqSEoiIVtLFLR6T
	 i8RlNuIIYiJ/iPliAKL4AkQbeLpPt21iLJ8qZZS5fstk7/tZtOdkBOigM3cpyrayMuJaP
	 mdNHA6RIcOraBYM4SJBBv1NkID0/5i7naxQnBOvY2oUwxrMZki65vaNTe2toLLh9JhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KAOaoeLM;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=OBz9MajD;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0D9606A89E
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 13:05:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A0D9606A89E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KAOaoeLM;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=OBz9MajD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794575140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v4TApKQ2t0hyQZxEXCOTGwfQDcbqzJhHn9ZrRsucxAk=;
	b=KAOaoeLMnVhC/CtgA6ZtRA23B1/xquuuEakQ0kMJlNFvA0L+nntEoIgfXb0aolyhkq7iro
	PM5rkjbx2wJZUwA7PyA0skf2+uAo6xoo6qj9NhQc1BgsIABP+AbHS8KtbGKaW5c99ZUQxR
	SqKGbCg6Pym4WT4CFOp8qgie6GlKmSQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-5FWrhLCXMRqqtY1UgF00JQ-1; Fri, 13 Nov 2026 08:05:39 -0500
X-MC-Unique: 5FWrhLCXMRqqtY1UgF00JQ-1
X-Mimecast-MFC-AGG-ID: 5FWrhLCXMRqqtY1UgF00JQ_1794575138
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-492b5408dedso489051f8f.3
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 05:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794575138; x=1795179938; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v4TApKQ2t0hyQZxEXCOTGwfQDcbqzJhHn9ZrRsucxAk=;
        b=OBz9MajDYVenCm8MUwg+HL9hyy/hjg7gXdoLfpQDTEBvcKFk4YaX7Tl44/rlnKnb5v
         srBQjbdSbBWBZPcxn1PCvXeu/Ks6Gvy2Titlk2bQEM78XcpFYAgC/2KkHvwx0b1eMl16
         fJqEP8wyrSh+PTfT8Q5vAzO/lPfDDbIdHdZPyVOUh5NF9jOK5LDk9hPIq/iH9JpeAkue
         raBwYvhyGwVeeSEq4hAtrs8tbzv0KpfcO77sH0pmSsQulx+UF9ep+lWXV/u+w78kH28r
         qz2J8dRVuL5lFl9EeQ8JjcRWpC9ounCRfBmSYjbhUwAFIjJ84CwdJl8oncnERZAetmJ2
         932w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794575138; x=1795179938;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v4TApKQ2t0hyQZxEXCOTGwfQDcbqzJhHn9ZrRsucxAk=;
        b=LAGVqGYjnGeIsFGlK0cnSX1fEZW4OauUucauk3qohV4Hq+EoCMTikFmSU21Eh0oSWS
         bV0xQf2n5zLsx1uTxSzrVlQaZsmmJT7LEuEmNiEeTcnPwqJko6rG4U9ocXxQnOYG8yjP
         zo3oJGIq4saKsxKLTDfnP8yeFNle0QtWebsQQSYVHun/YqSOfna1Ia63uI0kcMM9NpG+
         oQVfeRnI4LKQKX+G9M3Ijb90BDquDDSFyUDL4NdLmvjad4gF0au5PdLRiC1N+dw1L24g
         kBODKsYgWA3kggcSfP/dBc5rmzpJNCBwhCEBQieMEzZClAZonjltx88k+fRS0iAwQmo+
         vtmg==
X-Forwarded-Encrypted: i=1; AL+hErHC8nF1waSeggiBLNg+PJ5UZDTTWoBlYaT//0xp6BMWLFi0mG/mrv6vYl12rqtDLiOPfCQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/YaZ50jU6V1tmPXUbW7hMj9Vwad+fTfw91oFoxWi1SxIYvyPU1
	DrX1XTOR21HyA6vT0NkCUjAkX7tz8Ctt1E0Z60Q3sTgd+BSdwjYi6lXP20tIY8niEJ9DBwTra6R
	w7WQSARpMYU7/detd2XbDVsZ5QCJsEXcqGbT2/o56wnTR30xWbXwEuw==
X-Gm-Gg: AYBFou26pB5bQfOx85dEGxNzbXr41IuTPWu5MXi8DBfZg+DCa/kBT2sJfLKf1qdBIyn
	785pjQabat7xJ/6lmRTPxNcjKntAUsOCoe2Zjya0uslZQC6KMIt7DrI+Cy6Ff/iWgDTUDEmxkvX
	oHY9hUBXuS4ZxKs95rjdGZBiB0N4hARE+4+Chk0do+27j9IZ7/Fww213XW98bJC1J48vFU919on
	s5mtiY2335JFyMALDuNJ8F5Xmt5g4/gusDc16iUlpmMtiwRsr+I4ivletQLpLa/wJSldo7dO162
	cy6OntAYeu1qbjEwSGryHbK+wDU3hbuXcIQWDfkZojs9o6DidGIhaAEGk/lTdRW8X4RGiJhx2Ll
	18LuLkNBMTmpNt0U/MPSXUNsUyEfSALwjlDhTT5X6xw==
X-Received: by 2002:a05:600c:3487:b0:4a2:526b:d410 with SMTP id 5b1f17b1804b1-4bb55a4f1b4mr53874585e9.13.1794575137625;
        Fri, 13 Nov 2026 05:05:37 -0800 (PST)
X-Received: by 2002:a05:600c:3487:b0:4a2:526b:d410 with SMTP id 5b1f17b1804b1-4bb55a4f1b4mr53873365e9.13.1794575136910;
        Fri, 13 Nov 2026 05:05:36 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1511:2900:ff37:b35c:a97:952d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb56680ea9sm39056695e9.0.2026.11.13.05.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 05:05:35 -0800 (PST)
Date: Fri, 13 Nov 2026 08:05:30 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sergio Lopez <slp@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Alexei Starovoitov <ast@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	bpf@vger.kernel.org, linux-hyperv@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC v2 0/8] vsock: add datagram support to virtio and
 vhost
Message-ID: <20261113080506-mutt-send-email-mst@kernel.org>
References: <20261113-vsock-dgram-support-v2-0-bacfc85b71ce@redhat.com>
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
In-Reply-To: <20261113-vsock-dgram-support-v2-0-bacfc85b71ce@redhat.com>

On Fri, Nov 13, 2026 at 01:47:33PM +0100, Sergio Lopez wrote:
> This RFC adds SOCK_DGRAM support to virtio-vsock and vhost-vsock through
> the existing AF_VSOCK API. It is intended for guest and host services
> that exchange independent requests, responses, or events and need message
> boundaries and sender addresses without a stream connection or application
> framing.
> 
> VIRTIO_VSOCK_F_DGRAM gates virtio traffic in both directions. Each virtio
> send carries zero to 64 KiB of payload in one VIRTIO_VSOCK_TYPE_DGRAM
> packet. On the RX virtqueue, the device may split a datagram across
> page-sized guest buffers.
> START and EOM delimit the message; the guest reassembles at most 64
> fragments and 64 KiB before delivering it to a socket.

where do these limits come from? how does peer know not to send more?

Thanks!

> Invalid or
> incomplete messages are discarded. Datagram delivery is best effort:
> there are no peer credits, acknowledgements, or retransmissions. Send
> admission uses the socket send-memory limit, and SIOCOUTQ reports charged
> send memory.
> 
> Datagram sockets have a separate port space from stream and seqpacket
> sockets. The latter two continue to share their port space. Datagram
> routes are chosen per destination among guest-to-host, host-to-guest, and
> loopback transports, with VMCI as a fallback. VMCI still owns its socket
> handle when it is present; loopback works without a directional transport.
> Hyper-V continues to reject datagram sockets.
> 
> Bobby Eshleman and Amery Hung explored this feature in their v6 series
> and v7 work-in-progress branch. This series is a fresh implementation
> against the current vsock code. It follows the separate datagram port
> space, per-destination routing, and VMCI fallback requirements discussed
> there. For guest receive buffers, it uses bounded fragmentation and
> reassembly rather than full-message buffers or the earlier drop/error
> queue approach:
> 
> https://lore.kernel.org/r/20240710212555.1617795-1-amery.hung@bytedance.com
> https://github.com/ameryhung/linux/tree/vsock-dgram-v7
> 
> A corresponding virtio specification update has been drafted separately.
> The wire format and feature negotiation still need specification review
> before this series can be considered for merging.
> 
> The first patches expose the core port allocator and add datagram queue
> reporting, then implement the common data path, guest and host feature
> negotiation, routing, and RX fragmentation. The last patch extends
> vsock_test with local and peer tests for message boundaries, routing,
> connected peers, port sharing, queue accounting, and delayed reads.
> 
> Testing used QEMU with the F_DGRAM property patch below, an x86-64
> KASAN/lockdep kernel, paired guest tests, and a nested Linux vhost-vsock
> backend. The tested paths include 64 KiB messages, delayed-read bursts,
> feature-disabled ingress, stream and seqpacket controls, and header-only
> guest RX buffers. A temporary userspace backend still fails stream test
> 21 on both the series base and tip; that case passes with Linux vhost.
> Real VMCI and Hyper-V hardware were not exercised.
> 
> https://lists.gnu.org/archive/html/qemu-devel/2026-10/msg08074.html
> 
> Code was written and reviewed both manually and assisted by Codex
> (GPT-6.1-Sol) and Claude (Opus 4.6).
> 
> Signed-off-by: Sergio Lopez <slp@redhat.com>
> ---
> Changes in v2:
> - Keep guest RX buffers page-sized; add START/EOM framing and bounded
>   datagram reassembly (thanks to Alexei Starovoitov and Bobby Eshleman).
> - Preserve stream and seqpacket data when an RX buffer has no payload
>   room.
> - Separate datagram and connection-oriented port spaces, and share
>   receive metadata and queueing (thanks to Alexei Starovoitov).
> - Check negotiated support and destination CID on ingress, and require
>   an exact connected peer CID and port (thanks to Sashiko AI bot).
> - Select a capable route for each destination, retain VMCI as fallback,
>   and support loopback-only sockets (thanks to Alexei Starovoitov).
> - Preserve the connected peer address across temporary parent fallback
>   (thanks to Sashiko AI bot).
> - Use socket write-memory accounting for datagram SIOCOUTQ instead of
>   separate transport counters (thanks to Alexei Starovoitov).
> - Extend selftests for fragmentation, delayed reads, port sharing,
>   connected peers, and capability-based skips; fix the test build and
>   README entries (thanks to Alexei Starovoitov, Bobby Eshleman,
>   and Sashiko AI bot).
> - Link to v1: https://lore.kernel.org/r/20261028-vsock-dgram-support-v1-0-e457cf7cee78@sinrega.org
> 
> ---
> Sergio Lopez (8):
>       vsock: expose the core port allocator to transports
>       vsock: report datagram receive and send queue state
>       vsock/virtio: implement the datagram data path
>       vsock/virtio: negotiate datagram support on the guest
>       vhost/vsock: negotiate datagram support with guests
>       vsock: allow datagrams to use directional transports
>       vsock: fragment datagrams across receive buffers
>       vsock: add datagram tests to vsock_test
> 
>  Documentation/admin-guide/sysctl/net.rst |    8 +-
>  drivers/vhost/vsock.c                    |   51 +-
>  include/linux/virtio_vsock.h             |    9 +-
>  include/net/af_vsock.h                   |   30 +-
>  include/uapi/linux/virtio_vsock.h        |   10 +
>  net/vmw_vsock/af_vsock.c                 |  459 +++++++++++---
>  net/vmw_vsock/hyperv_transport.c         |   11 +-
>  net/vmw_vsock/virtio_transport.c         |  167 ++++-
>  net/vmw_vsock/virtio_transport_common.c  |  164 ++++-
>  net/vmw_vsock/vmci_transport.c           |  115 ++--
>  net/vmw_vsock/vsock_bpf.c                |    3 +-
>  net/vmw_vsock/vsock_loopback.c           |    2 +-
>  tools/testing/vsock/Makefile             |    3 +-
>  tools/testing/vsock/README               |   31 +-
>  tools/testing/vsock/util.c               |   62 +-
>  tools/testing/vsock/util.h               |   10 +
>  tools/testing/vsock/vsock_test.c         |  175 +++++-
>  tools/testing/vsock/vsock_test_dgram.c   | 1000 ++++++++++++++++++++++++++++++
>  tools/testing/vsock/vsock_test_dgram.h   |   29 +
>  19 files changed, 2066 insertions(+), 273 deletions(-)
> ---
> base-commit: 65ba8f34ec886ec72b2c07ddc8cf3d815c32869d
> change-id: 20261027-vsock-dgram-support-683a4e0aebe7
> 
> Best regards,
> -- 
> Sergio Lopez <slp@redhat.com>

