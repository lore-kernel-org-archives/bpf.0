Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209C0303C97
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 01:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774921839; cv=pass; b=Gky1H2gCBwOu8SMDcGr54MpDVWECYiE40wtR3+wLz+E7ojxLg54SgNsfGn92VJix3DXcyGOKpMt3S9YgUBlQkLLfjL4kHasKkJzgDjHVu8ksEVsTfo3Y02PvAquHIAGNGYcj81bBusfOYjgEIBg4uwFJtpmZj5kW9Ax7Kbxhrs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774921839; c=relaxed/simple;
	bh=8gYmI+YOdsaMkFuEayCBQbVk/v3bRpvOLfsbM+msETo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OywLJqL8L3t5wY+eyGhQLPlU/L3ZzMR88GXKx4A0Qtqlaft2Qu5AmqhjceCBUEUU53+wjNMMDWBWma3v7rRN7DRZLVdq0i243SdHOJGSCuRQiPEQtDo0MNzjsZwEPYxW3mqVV11vF9qM8aIExC4ongV6tKHgebHEyynPszcDsVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wL7q1DXt; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wL7q1DXt"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-12a695044a4so1592979c88.0
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 18:50:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774921836; cv=none;
        d=google.com; s=arc-20240605;
        b=Q8JqejqzSOKLBA0RU2T0+iFksOOZ26Biko+0Tw5vmy2M507+awNFwHClko+jOoB+qK
         DPs252T7Z5E4rfy45G+HuFjgFcpao3ZwDWNo7rKsj8rVssOSVLyD30pR5xXGZvCIkq6U
         WhclBK/8Mp528cxkIGB9K5a6noqhmOjoayyBNI1IR2S36+NPhiLZwug5qx2y9AiMyHbX
         f/Fw1DSNILyba/G2HVW1lIrqNnpc7V2WRJOCgZgBvZv68wA6YuNQO/P9kTOGVjfVUXi0
         uV6zl7URXdJl8Ka3b6MoC8wVYci7vYyZAv+cQMtIiOocGLFG+QfAv5pLouT5GFgi2NB3
         LekQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6f292/btZn8ISsDnTBi4fWU5y3QaKwgLkJGaHERz/GA=;
        fh=M8QFFytfFbDaAbeySA0HRDGi5VxhQ4q/Zc8nTLuNb1Y=;
        b=BayqKPMclUk442GpxjFudwm6r+G11EPaFoqGRyAxAqnonxKrZDX4LsdFtDRdXXm/3P
         o9uTjnjKdp65fW0Zr+t0OwlXsUiL2W2S8ElanP2VlU19DsCtT+Kl2QKzLrHvm62JVIIB
         n5FmXdNbOXZPUyWfuNceZfOAXl3u6aQ5vH+sCWd5n0RAGhiJDBGW6K2l/CU7lhX4H7EU
         1NCR85EXtKxvYlLNQUvgv9bfonS0NRqno7VXx2vclxiAzGOQNT+Syvb6SPs3Gt/QZsx4
         ncn9Gug9JMpIRuUntSb3ooBr8udPQWnrybKxcAjZrc6GU37YJ0OoSiHrAOUfiTC7FpkD
         9bnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774921836; x=1775526636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6f292/btZn8ISsDnTBi4fWU5y3QaKwgLkJGaHERz/GA=;
        b=wL7q1DXttVRMShI/54+X0HIyNm27HysiHL/kCP/4eRKtQX9b6j33uMZEms/aNUfg9X
         nzh9uFAT/jxftP19ICnr+jIcyFJ+Qx8sOzLDlJAz94TkVm7Cs1Bc8ETm9CoY6m5JyiCY
         sZhhIsffCmkUnHLxGtn7g4vDNmTjXLeQLbb4e/Ogjx3o9W0uwjoOilsXyJDDXid76CFD
         PbDD1R3caHI+FeLQdcFo931UGcVjvM9KtU+HnZK3GvSyRqcGS4/6gfeyRIfMz4Yf1xiG
         8OUpAAgbmL9sLQQ+GX9tfCs/a+AYNSe2tlKvt5InqD2RQUVepduL7fCkoT6zrQROVEj5
         FDBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774921836; x=1775526636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6f292/btZn8ISsDnTBi4fWU5y3QaKwgLkJGaHERz/GA=;
        b=lOs8c/NomxjydQfVaUPLi0Nib5P66r1xyjK88Yi9xHJh8+cFhj/lZ4ZXlIBvz4P4TV
         UjA3zq0jTO/Njb8XyHCIz1jmKsb28L89WeD5JeHX0tryiyK0TQ8ILRru0aFpXa0Bm6V6
         FzCbYX0I1v/VQH6OYtxvBd1LXukFtspl4yeeJNPyruiTEylrZfIzHSNceFkNtX7Dy60L
         3ibBR90Bo0lfKwApBepVzjZfyDdRuvpWnQ4Me15y4/eX84HouLQym6Su20AgMktmLV7F
         90NiiHMLN8C0FgD9LZAkWhmrMk3G2s5aXt9qIfEi26cZO/EZld9IpYszNfc9GtR0qZv5
         9lVA==
X-Gm-Message-State: AOJu0YyXG2VBhf46zjEC7sa27ACua27gmswXcPhf89fxLYVU4PO2jxlT
	UA+pazNJkcawm8D/6WzrVdntGyyh+BJyeMypg8Ee2MUsST63A/WmzPsS6CLx4zIpG9LkXq5IHPi
	0NYT6wy9jW7NXbCZzZ3eUVt/5S6Za25d22lo7w1RRXqFAls+ada9BIVoLtmA=
X-Gm-Gg: ATEYQzwhOn0bWJcNDC5ZkgfCwB9XkLymGr7PTUA+kK9Tj0oRJfYGX9MsWSW78BsE+5W
	3Qz5ZSG7ZxjSNI3L1MiEYYUGGxxKrGkkGonkdKOBFc39CjuhUlfC6TgqibKvSBsqZDZCvtO2o1I
	tQB05Q56UX9v1lmOEEkaOwpvZOVIKJK2ZlxbGynPuPD8MZaxaQOh7shHXUSjzRXzbug7gSb/bv5
	/LlwDhk5bs9Y9ojRcAoX1OHLQZJwgrdWcIeV5HgCOEIoUAEqh7PreeHB5xGNBFoMU4zaJJkFEZ6
	krev7FTr5oNdNIjwmUg+nsYB5ftFqxizp7PDRVFgwXwFoz0c2hq8zdpOxgRCwRVW2ARg3zrL
X-Received: by 2002:a05:7022:b8a:b0:11f:3483:bba6 with SMTP id
 a92af1059eb24-12ab2877032mr8903559c88.13.1774921835563; Mon, 30 Mar 2026
 18:50:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330080746.319680-1-jiayuan.chen@linux.dev> <20260330080746.319680-3-jiayuan.chen@linux.dev>
In-Reply-To: <20260330080746.319680-3-jiayuan.chen@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 30 Mar 2026 18:50:24 -0700
X-Gm-Features: AQROBzCq4WwavAHbnWGH3R8xHzPtillBgY_yUz44-mHnTtUOFzp1taa1gZwbEhs
Message-ID: <CAAVpQUA0kxiQVevVpty8V54HJw+=CR_GqDV2+Hg7OF8pZVTtVg@mail.gmail.com>
Subject: Re: [PATCH bpf v4 2/2] selftests/bpf: Add protocol check test for bpf_sk_assign_tcp_reqsk()
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 1:08=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
> Add test_tcp_custom_syncookie_protocol_check to verify that
> bpf_sk_assign_tcp_reqsk() rejects non-TCP skbs. The test sends a UDP
> packet through TC ingress where a BPF program calls
> bpf_sk_assign_tcp_reqsk() on it and checks that the kfunc returns an
> error. A UDP server recv() is used as synchronization to ensure the
> BPF program has finished processing before checking the result.
>
> Without the fix in bpf_sk_assign_tcp_reqsk(), the kfunc succeeds and
> attaches a TCP reqsk to the UDP skb, which causes a null pointer
> dereference panic when the kernel processes it through the UDP receive
> path.
>
> Test result:
>
>   ./test_progs -a tcp_custom_syncookie_protocol_check -v
>   setup_netns:PASS:create netns 0 nsec
>   setup_netns:PASS:ip 0 nsec
>   write_sysctl:PASS:open sysctl 0 nsec
>   write_sysctl:PASS:write sysctl 0 nsec
>   setup_netns:PASS:write_sysctl 0 nsec
>   test_tcp_custom_syncookie_protocol_check:PASS:open_and_load 0 nsec
>   setup_tc:PASS:qdisc add dev lo clsact 0 nsec
>   setup_tc:PASS:filter add dev lo ingress 0 nsec
>   run_protocol_check:PASS:start tcp_server 0 nsec
>   run_protocol_check:PASS:start udp_server 0 nsec
>   run_protocol_check:PASS:connect udp_client 0 nsec
>   run_protocol_check:PASS:send udp 0 nsec
>   run_protocol_check:PASS:recv udp 0 nsec
>   run_protocol_check:PASS:udp_intercepted 0 nsec
>   run_protocol_check:PASS:assign_ret 0 nsec
>   #471/1   tcp_custom_syncookie_protocol_check/IPv4 TCP:OK
>   run_protocol_check:PASS:start tcp_server 0 nsec
>   run_protocol_check:PASS:start udp_server 0 nsec
>   run_protocol_check:PASS:connect udp_client 0 nsec
>   run_protocol_check:PASS:send udp 0 nsec
>   run_protocol_check:PASS:recv udp 0 nsec
>   run_protocol_check:PASS:udp_intercepted 0 nsec
>   run_protocol_check:PASS:assign_ret 0 nsec
>   #471/2   tcp_custom_syncookie_protocol_check/IPv6 TCP:OK
>   #471     tcp_custom_syncookie_protocol_check:OK
>   Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED
>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>  .../bpf/prog_tests/tcp_custom_syncookie.c     |  91 ++++++++++++++-
>  .../bpf/progs/test_tcp_custom_syncookie.c     | 109 ++++++++++++++++++
>  2 files changed, 196 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/tcp_custom_syncookie.=
c b/tools/testing/selftests/bpf/prog_tests/tcp_custom_syncookie.c
> index eaf441dc7e79..6e29402c4c59 100644
> --- a/tools/testing/selftests/bpf/prog_tests/tcp_custom_syncookie.c
> +++ b/tools/testing/selftests/bpf/prog_tests/tcp_custom_syncookie.c
> @@ -5,6 +5,7 @@
>  #include <sched.h>
>  #include <stdlib.h>
>  #include <net/if.h>
> +#include <netinet/in.h>
>
>  #include "test_progs.h"
>  #include "cgroup_helpers.h"
> @@ -47,11 +48,10 @@ static int setup_netns(void)
>         return -1;
>  }
>
> -static int setup_tc(struct test_tcp_custom_syncookie *skel)
> +static int setup_tc(int prog_fd)
>  {
>         LIBBPF_OPTS(bpf_tc_hook, qdisc_lo, .attach_point =3D BPF_TC_INGRE=
SS);
> -       LIBBPF_OPTS(bpf_tc_opts, tc_attach,
> -                   .prog_fd =3D bpf_program__fd(skel->progs.tcp_custom_s=
yncookie));
> +       LIBBPF_OPTS(bpf_tc_opts, tc_attach, .prog_fd =3D prog_fd);
>
>         qdisc_lo.ifindex =3D if_nametoindex("lo");
>         if (!ASSERT_OK(bpf_tc_hook_create(&qdisc_lo), "qdisc add dev lo c=
lsact"))
> @@ -127,7 +127,7 @@ void test_tcp_custom_syncookie(void)
>         if (!ASSERT_OK_PTR(skel, "open_and_load"))
>                 return;
>
> -       if (setup_tc(skel))
> +       if (setup_tc(bpf_program__fd(skel->progs.tcp_custom_syncookie)))
>                 goto destroy_skel;
>
>         for (i =3D 0; i < ARRAY_SIZE(test_cases); i++) {
> @@ -145,6 +145,89 @@ void test_tcp_custom_syncookie(void)
>
>  destroy_skel:
>         system("tc qdisc del dev lo clsact");
> +       test_tcp_custom_syncookie__destroy(skel);
> +}
> +
> +/* Test: bpf_sk_assign_tcp_reqsk() should reject non-TCP skb.
> + *
> + * Send a UDP packet through TC ingress where a BPF program calls
> + * bpf_sk_assign_tcp_reqsk() on it. The kfunc should return an error
> + * because the skb carries UDP, not TCP.
> + *
> + * TCP and UDP servers share the same port. The BPF program intercepts
> + * the UDP packet, looks up the TCP listener via the dest port, and
> + * attempts to assign a TCP reqsk to the UDP skb.
> + */
> +static void run_protocol_check(struct test_tcp_custom_syncookie *skel,
> +                              int family, const char *addr)
> +{
> +       int tcp_server =3D -1, udp_server =3D -1, udp_client =3D -1;

nit: no need to init.

> +       char buf[32] =3D "test";

should be buf[] =3D "test" since you send data of sizeof(buf) below.


> +       int port, ret;
> +
> +       tcp_server =3D start_server(family, SOCK_STREAM, addr, 0, 0);
> +       if (!ASSERT_NEQ(tcp_server, -1, "start tcp_server"))
> +               return;
> +
> +       port =3D ntohs(get_socket_local_port(tcp_server));
> +
> +       /* UDP server on same port for synchronization and port sharing *=
/
> +       udp_server =3D start_server(family, SOCK_DGRAM, addr, port, 0);
> +       if (!ASSERT_NEQ(udp_server, -1, "start udp_server"))
> +               goto close_tcp;
> +
> +       skel->bss->udp_intercepted =3D false;
> +       skel->bss->assign_ret =3D 0;
> +
> +       udp_client =3D connect_to_fd(udp_server, 0);
> +       if (!ASSERT_NEQ(udp_client, -1, "connect udp_client"))
> +               goto close_udp_server;
>
> +       ret =3D send(udp_client, buf, sizeof(buf), 0);
> +       if (!ASSERT_EQ(ret, sizeof(buf), "send udp"))
> +               goto close_udp_client;

memset(buf, 0, sizeof(buf)) here and

> +
> +       /* recv() ensures TC ingress BPF has processed the skb */
> +       ret =3D recv(udp_server, buf, sizeof(buf), 0);
> +       if (!ASSERT_EQ(ret, sizeof(buf), "recv udp"))

check ASSERT_STREQ() here ?

> +               goto close_udp_client;
> +
> +       ASSERT_EQ(skel->bss->udp_intercepted, true, "udp_intercepted");
> +
> +       ASSERT_EQ(skel->bss->assign_ret, -EINVAL, "assign_ret");
> +
> +close_udp_client:
> +       close(udp_client);
> +close_udp_server:
> +       close(udp_server);
> +close_tcp:
> +       close(tcp_server);
> +}
> +
> +void test_tcp_custom_syncookie_protocol_check(void)
> +{
> +       struct test_tcp_custom_syncookie *skel;
> +       int i;
> +
> +       if (setup_netns())
> +               return;
> +
> +       skel =3D test_tcp_custom_syncookie__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "open_and_load"))
> +               return;
> +
> +       if (setup_tc(bpf_program__fd(skel->progs.tcp_custom_syncookie_bad=
proto)))
> +               goto destroy_skel;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(test_cases); i++) {
> +               if (!test__start_subtest(test_cases[i].name))
> +                       continue;
> +
> +               run_protocol_check(skel, test_cases[i].family,
> +                                  test_cases[i].addr);
> +       }
> +
> +destroy_skel:
> +       system("tc qdisc del dev lo clsact");
>         test_tcp_custom_syncookie__destroy(skel);
>  }
> diff --git a/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.=
c b/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c
> index 7d5293de1952..bd3fad3dd503 100644
> --- a/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c
> +++ b/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c
> @@ -588,4 +588,113 @@ int tcp_custom_syncookie(struct __sk_buff *skb)
>         return tcp_handle_ack(&ctx);
>  }
>
> +/* Test: call bpf_sk_assign_tcp_reqsk() on a UDP skb.
> + * The kfunc should reject it because the skb is not TCP.
> + *
> + * TCP and UDP servers share the same port. The BPF program intercepts
> + * UDP packets, looks up the TCP listener on the same port, and tries
> + * to assign a TCP reqsk to the UDP skb.
> + */
> +int assign_ret =3D 0;
> +bool udp_intercepted =3D false;

No need to init var on bss w/ 0 here.
(init in run_protocol_check() is necessary)


> +
> +static int badproto_lookup_assign(struct __sk_buff *skb, struct udphdr *=
udp,
> +                                 struct bpf_sock_tuple *tuple, u32 tuple=
_size)
> +{
> +       struct bpf_tcp_req_attrs attrs =3D {};
> +       struct bpf_sock *skc;
> +       struct sock *sk;
> +
> +       skc =3D bpf_skc_lookup_tcp(skb, tuple, tuple_size, -1, 0);
> +       if (!skc)
> +               return TC_ACT_OK;
> +
> +       if (skc->state !=3D TCP_LISTEN) {
> +               bpf_sk_release(skc);
> +               return TC_ACT_OK;
> +       }
> +
> +       sk =3D (struct sock *)bpf_skc_to_tcp_sock(skc);
> +       if (!sk) {
> +               bpf_sk_release(skc);
> +               return TC_ACT_OK;
> +       }
> +
> +       attrs.mss =3D 1460;
> +       attrs.wscale_ok =3D 1;
> +       attrs.snd_wscale =3D 7;
> +       attrs.rcv_wscale =3D 7;
> +       attrs.sack_ok =3D 1;
> +
> +       assign_ret =3D bpf_sk_assign_tcp_reqsk(skb, sk, &attrs, sizeof(at=
trs));
> +
> +       bpf_sk_release(skc);
> +       return TC_ACT_OK;
> +}
> +
> +SEC("tc")
> +int tcp_custom_syncookie_badproto(struct __sk_buff *skb)
> +{
> +       void *data =3D (void *)(long)skb->data;
> +       void *data_end =3D (void *)(long)skb->data_end;
> +       struct bpf_sock_tuple tuple =3D {};
> +       struct ethhdr *eth;
> +       struct iphdr *iph;
> +       struct ipv6hdr *ip6h;
> +       struct udphdr *udp;
> +
> +       eth =3D (struct ethhdr *)data;
> +       if (eth + 1 > data_end)
> +               return TC_ACT_OK;
> +
> +       switch (bpf_ntohs(eth->h_proto)) {
> +       case ETH_P_IP:
> +               iph =3D (struct iphdr *)(eth + 1);
> +               if (iph + 1 > data_end)
> +                       return TC_ACT_OK;
> +
> +               if (iph->protocol !=3D IPPROTO_UDP)
> +                       return TC_ACT_OK;
> +
> +               udp =3D (struct udphdr *)(iph + 1);
> +               if (udp + 1 > data_end)
> +                       return TC_ACT_OK;
> +
> +               udp_intercepted =3D true;
> +
> +               tuple.ipv4.saddr =3D iph->saddr;
> +               tuple.ipv4.daddr =3D iph->daddr;
> +               tuple.ipv4.sport =3D udp->source;
> +               tuple.ipv4.dport =3D udp->dest;
> +
> +               return badproto_lookup_assign(skb, udp, &tuple,
> +                                             sizeof(tuple.ipv4));
> +       case ETH_P_IPV6:
> +               ip6h =3D (struct ipv6hdr *)(eth + 1);
> +               if (ip6h + 1 > data_end)
> +                       return TC_ACT_OK;
> +
> +               if (ip6h->nexthdr !=3D IPPROTO_UDP)
> +                       return TC_ACT_OK;
> +
> +               udp =3D (struct udphdr *)(ip6h + 1);
> +               if (udp + 1 > data_end)
> +                       return TC_ACT_OK;
> +
> +               udp_intercepted =3D true;
> +
> +               __builtin_memcpy(tuple.ipv6.saddr, &ip6h->saddr,
> +                                sizeof(tuple.ipv6.saddr));
> +               __builtin_memcpy(tuple.ipv6.daddr, &ip6h->daddr,
> +                                sizeof(tuple.ipv6.daddr));
> +               tuple.ipv6.sport =3D udp->source;
> +               tuple.ipv6.dport =3D udp->dest;
> +
> +               return badproto_lookup_assign(skb, udp, &tuple,
> +                                             sizeof(tuple.ipv6));
> +       default:
> +               return TC_ACT_OK;
> +       }
> +}
> +
>  char _license[] SEC("license") =3D "GPL";
> --
> 2.43.0
>
