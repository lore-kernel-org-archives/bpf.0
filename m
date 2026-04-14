Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9096C23C8C7
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 05:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776145848; cv=pass; b=Y3sdrh2UKLVRyBukm0hZ98/4faC1BhYKtEJLnVuEcBxEu3kC2FqzIZTW3G61kMQNi0g9vv2uKYNZzk3zwNTZmcapCStQH+POAFIeknMRzlLK/ExdNLAHaO3AoMPpdQ7DajHiPIWE53FYiqdiy4R1GFJxeTZ25pd+mTw8SWFAjME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776145848; c=relaxed/simple;
	bh=b4MyJjck3xfnzqA3Mpwj4CRB14hfvnO16wBz1wVugbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CKNOqvgPjEHRIdPLXh5Y2xJVN6Ifj76QueFLLT2tNayX0uQj80xOsaI41K5q8nv5isLrHRp4JLrUn1zbMsN1YjUaJ+jrehcMt/CBbYSww0Aa1sRj6sfy1DUU4XXjdS1gAZKQn37W0SwISJftFrhGbG+2hislkGdq66iGKZHIf9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dTPhZVYs; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dTPhZVYs"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-12c287eb77fso6903294c88.1
        for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 22:50:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776145847; cv=none;
        d=google.com; s=arc-20240605;
        b=IRvnn30Cz4DO2lE3U5gPI9W/Frcvfq9/MCngkn+VUs60QU6HSNmtIt7Sesuwn3Sx2o
         9JaeaDhTtULcoKu8jVqO7UfHfdl+jLaChXuFvVh5dBHU5gIc83urXPH9stUfxJh/Xg64
         oBKskwcK/SAlJcCc4vrcZBPconQIORu13sIcalEA3AP4IaLjN/ppeSPJgipkHXNrN5BC
         hjo2kzpQ/lP+mrg5SCqApzAOkll1x94J4E6Urrw3HqyChnGuhYl900oMbHKLdvUTHe5H
         WOO5likjMej91RBqpGhPeaYdP1BsSb1523FAeujFXbFYtZTA9P+OEZn2h5/3RNHszjtC
         XAWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N8xC/w8t49636DlDIJyIeZJFwbUar3vdMzMLV+P2FdY=;
        fh=7dUd0lwoAtsp86eyVRIswBRo39fbDUpXnvaDdaT1zV4=;
        b=S1UXEDg7iE7wUXZ7DM/dIWFKpe5TZR7L0DJuuc6y0mdT7NudBGf7CpfIUyFWS7qM0C
         VbzVOnQOrNR6H/MtaXUh7D06L2Joz8FBZqIVMpYktlECY1dIP00Ceydme/uMH0RngXF4
         3h9VfoPTYY9sEh2MCuStmYUdGh4B/v5/qGwftQQtxLg1cj5jUBBYiRz4YgcmqCdCJcGY
         znu4qHltefS2iPizgzOR8MFTYQt49yGhK0vZYHMwCiszz9L5ZLCv++AnQbzKIpek/Eww
         2e3T91YjGoNkbKQJ/xm3frNfxKWgZFnhw9TiKS5JBhusO2WqAy86VSXvqQwIMFxz7C8e
         9/pg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776145847; x=1776750647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N8xC/w8t49636DlDIJyIeZJFwbUar3vdMzMLV+P2FdY=;
        b=dTPhZVYss+yPe/7Qym9Fuxtiel/72rKV5iKEhnNLB7MmjcXdf0jcytvVZUt8PjFNmV
         aZx2Jim0FLyTvcOZ0ecH5OzXjvxWPUFzm65P+KJw+4Dy9KczVv7yulTWGyUP3HCw1Dfb
         /xAM+fVcwzU28L3KzNrfWxUH1H9+Nm49MnVApqA7PfTqhIrmYHSiztYa+4WlBkPUaeej
         wHQugfZlywTb2Nh/NeM4CN7wMKXnHutlIB0oOJ+m/sMVaKn/U0R0nDXkwjTCT84U+I1C
         KKCoCXmaGnCHR5zELvBSEvK9EFuby/9a0gSOdzcgGD94Q1v6T1Ieq/RJEJ2OV7aJrjcy
         6wmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776145847; x=1776750647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N8xC/w8t49636DlDIJyIeZJFwbUar3vdMzMLV+P2FdY=;
        b=DNS8MJdfjKq3+1k4HHDeXQ+l/XExoLPGMzIhRKX4Xt5psI0TZ0E1JcRwJcf4q5ig6B
         hVM63zxcyoPFmH2+7wvF/JD59Bq0Mk3/esvMiFy+IzhthPQp5HObEWAHJJUGmpw0ghFM
         CybQWA5lfMkhZr/bm5Pep1DIFrZ7dJTBaee2VLCq8KbD2vgjV9LY5fzxcu5ThahUPRtM
         jt0P4oq+T9BmNjPnIdMC9RrEH7P5bKC0MzDxIuLcxrPtJMu30692i/t4/t4EeByuMji6
         qvJsolz2c2mVzFhIIpApTjVnPYaG7Osx9GY0trI4iGcINcxEN76VLQQl7iGbWisVI2wk
         WzjA==
X-Forwarded-Encrypted: i=1; AFNElJ/5cGRcWnmjpLqYQoB2y5oZGTpsJQgBX/qmdQQecnYPYndRbKuRfiy2sVKxT37lAH3QjR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFG2v0uiiA/uYQFfuo+vX1zxx0VwFcp/aWkGkYOtb9sID+jdbQ
	oHamasTwkoiULmciCJ0pbKkcbbAngfZs/y2FcPMJ8GtQywG7pyh1l+wrHurx25mCpqK4JynVin7
	lEhjuR1vWx7W5AINDwV052ao5XXFeBn4BmfM0/8Uk
X-Gm-Gg: AeBDiev3gFJCuy6GucWTRTJn+8+nE3C9s/lL3kJcGSRiLrLQrxtlxh7TVqMoL77mhji
	l+MjAv46iDTrMLztqmiSx92oRcYiJ2akiD8QB3RwzUeN0gV8HiWV0MB8naK3PGvMqU35rMssPZl
	KpQkCLLDMvJRW1442NkxPsxaEzttMw83nNhjIod8NSkHiwfqNaJX6s0hZMjRE42pSF4DBEdKZhT
	XU2zbt9uyiktwS7D+cDRV/q6nHA09ewZ+3fDIaavUSD0UXblK50NXKidTIE1fg+xE5oxv9t4IYH
	nMtr++fJgY37CfB/Xai6HAnGYCK3fTS3M6nR4E5npd6JR1iFNzYM7qqdOPVIQpenHVcKg02LC3z
	7W/nkdyEIWrn4zWWwBJbQo9bk6XwBc7P33Un3rCcUtnEmCjavK+lTKUldBd7rwtzkDyCihQyutQ
	==
X-Received: by 2002:a05:7022:698a:b0:12a:68cc:3efb with SMTP id
 a92af1059eb24-12c34ebade5mr10496341c88.16.1776145845960; Mon, 13 Apr 2026
 22:50:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260411013211.225834-1-jiayuan.chen@linux.dev> <20260411013211.225834-2-jiayuan.chen@linux.dev>
In-Reply-To: <20260411013211.225834-2-jiayuan.chen@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 13 Apr 2026 22:50:34 -0700
X-Gm-Features: AQROBzDT2dbg9kp2qWFhZweYdMBKd3sH2bKQwiV-CoaMbLvgWGw0Wl0--ydKlAE
Message-ID: <CAAVpQUCCZVogDUUTfr3k-JxV52kpVvdYzqFC68-J3n6_ugd4Uw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/2] selftests/bpf: verify syncookie
 statistics in tcp_custom_syncookie
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2026 at 6:32=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
> Add read_tcpext_snmp() helper to network_helpers which reads a
> TcpExt SNMP counter via nstat, and use it in the tcp_custom_syncookie
> test to verify that LINUX_MIB_SYNCOOKIESRECV is incremented and
> LINUX_MIB_SYNCOOKIESFAILED stays unchanged across a successful
> BPF custom syncookie validation.
>
> The delta is captured between start_server() and accept(), which
> covers the full SYN/ACK/cookie-check path for one connection.
>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>  tools/testing/selftests/bpf/network_helpers.c | 22 +++++++++++++++++++
>  tools/testing/selftests/bpf/network_helpers.h |  1 +
>  .../bpf/prog_tests/tcp_custom_syncookie.c     | 20 +++++++++++++++++

As you touch bpf selftest helper files, please rebase on bpf-next
to avoid possible conflicts and tag bpf-next in the Subject.

Change itself looks good.

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

one nit below.


>  3 files changed, 43 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testin=
g/selftests/bpf/network_helpers.c
> index b82f572641b7..3388dd5112b6 100644
> --- a/tools/testing/selftests/bpf/network_helpers.c
> +++ b/tools/testing/selftests/bpf/network_helpers.c
> @@ -621,6 +621,28 @@ int get_socket_local_port(int sock_fd)
>         return -1;
>  }
>
> +int read_tcpext_snmp(const char *name, unsigned long *val)
> +{
> +       char cmd[128], buf[128];
> +       int ret =3D 0;
> +       FILE *f;
> +
> +       snprintf(cmd, sizeof(cmd),
> +                "nstat -az TcpExt%s | awk '/TcpExt/ {print $2}'", name);
> +       f =3D popen(cmd, "r");
> +       if (!f)
> +               return -errno;
> +
> +       if (!fgets(buf, sizeof(buf), f)) {
> +               ret =3D ferror(f) ? -errno : -ENODATA;
> +               goto out;
> +       }
> +       *val =3D strtoul(buf, NULL, 10);
> +out:
> +       pclose(f);
> +       return ret;
> +}
> +
>  int get_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param)
>  {
>         struct ifreq ifr =3D {0};
> diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testin=
g/selftests/bpf/network_helpers.h
> index 79a010c88e11..c53cd781df6e 100644
> --- a/tools/testing/selftests/bpf/network_helpers.h
> +++ b/tools/testing/selftests/bpf/network_helpers.h
> @@ -84,6 +84,7 @@ int make_sockaddr(int family, const char *addr_str, __u=
16 port,
>                   struct sockaddr_storage *addr, socklen_t *len);
>  char *ping_command(int family);
>  int get_socket_local_port(int sock_fd);
> +int read_tcpext_snmp(const char *name, unsigned long *val);
>  int get_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param)=
;
>  int set_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param)=
;
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/tcp_custom_syncookie.=
c b/tools/testing/selftests/bpf/prog_tests/tcp_custom_syncookie.c
> index eaf441dc7e79..6adfb4b892f8 100644
> --- a/tools/testing/selftests/bpf/prog_tests/tcp_custom_syncookie.c
> +++ b/tools/testing/selftests/bpf/prog_tests/tcp_custom_syncookie.c
> @@ -91,12 +91,21 @@ static void transfer_message(int sender, int receiver=
)
>
>  static void create_connection(struct test_tcp_custom_syncookie_case *tes=
t_case)
>  {
> +       unsigned long recv_before, recv_after;
> +       unsigned long failed_before, failed_after;

While at it, please keep reverse xmas tree order


>         int server, client, child;
>
>         server =3D start_server(test_case->family, test_case->type, test_=
case->addr, 0, 0);
>         if (!ASSERT_NEQ(server, -1, "start_server"))
>                 return;
>
> +       if (!ASSERT_OK(read_tcpext_snmp("SyncookiesRecv", &recv_before),
> +                      "read SyncookiesRecv before"))
> +               goto close_server;
> +       if (!ASSERT_OK(read_tcpext_snmp("SyncookiesFailed", &failed_befor=
e),
> +                      "read SyncookiesFailed before"))
> +               goto close_server;
> +
>         client =3D connect_to_fd(server, 0);
>         if (!ASSERT_NEQ(client, -1, "connect_to_fd"))
>                 goto close_server;
> @@ -105,9 +114,20 @@ static void create_connection(struct test_tcp_custom=
_syncookie_case *test_case)
>         if (!ASSERT_NEQ(child, -1, "accept"))
>                 goto close_client;
>
> +       if (!ASSERT_OK(read_tcpext_snmp("SyncookiesRecv", &recv_after),
> +                      "read SyncookiesRecv after"))
> +               goto close_child;
> +       if (!ASSERT_OK(read_tcpext_snmp("SyncookiesFailed", &failed_after=
),
> +                      "read SyncookiesFailed after"))
> +               goto close_child;
> +
> +       ASSERT_EQ(recv_after - recv_before, 1, "SyncookiesRecv delta");
> +       ASSERT_EQ(failed_after - failed_before, 0, "SyncookiesFailed delt=
a");
> +
>         transfer_message(client, child);
>         transfer_message(child, client);
>
> +close_child:
>         close(child);
>  close_client:
>         close(client);
> --
> 2.43.0
>
