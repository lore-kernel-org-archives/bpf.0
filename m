Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793301168;
	b=Y8GNSDRzXEnnO9uRmcUWobIccpYUl3v9OQlJSvscZTCJ9E1TKf1RZmHPdu3FMhtrN6Co
	 ckAYM/dYrecBku8CkYS5K7LpbeRpbqqiq9JX0aQPtq3kDOvFuTkKVdo6WLNdfvSC4E5d9
	 x6RuiFU/LVP7mxqsrREe4p2Cdr94pUU5n+dBGRwbU8gFFABJ1dYpLYuJhwjXbXl4NkBlT
	 zL8Ox1RluNiQdeB8GGvK7/lxClc0HrOennCiOSZBC6td27pqF56wyiv0hreGO97k3QwTi
	 KNzx9wcr2T/da5efRWUUGwg3SU1WNCjEbTNLThTKTazG/lTPS0vijBPWgpFoHnaw9xA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793301168;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=fjHuvuN49PF5vOKkhnM73iDNLwhHMurb9TJDZurmi9M=;
	b=EQQSw69bvz2hR4Fhf/d7Fp5txs86kHZzouGWu6X8E+IYUWCIW2fvZPX7GN2FYffm9OlY
	 KDx872W5MsgMHR/jLiuv5ZWMLZaSCfn8nHFjDgBfiXNyy28l3cs5oFMvH3bk3hEJDf+jI
	 1E7z5M2mnZuW3VPN/1hdrILOWvTTy8KK75AEICLSJT7kyZAWbk/E1lDooDaWRNc+39QrO
	 V3K4OqYn+h67v9gsF9+y7CbuJRM9PGn1ZKe/nQuIOla1dH+WiVrnfDyNtx1nKCq7TyTKy
	 Jw1yUfjdr/WoCCxTBBH6AMgwL/91dF4eAgpVZTvtneD4FWTbdgthsno+Ousbu7pVNzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i8IJU3lY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45817606A31E
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 19:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i8IJU3lY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03F711F01824;
	Thu, 29 Oct 2026 19:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793301168;
	bh=fjHuvuN49PF5vOKkhnM73iDNLwhHMurb9TJDZurmi9M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i8IJU3lY0T5HP1gQaSTSqgzHcZpTKk6/Q1RU5c6IvyyCUCmw0PPvjCfidEPC1NZUm
	 UFOtH2jMtqZ5t9sfeKewpeJjoFsumfGmkyVGAPoLld26EBzSM/s9edriq8FN6P+AqO
	 C01JjPLX+wYVCOxbCMkuKS0bxZs8szEG5GrWIxUtgqHP3Qeq8bn9UBY+Bosbr1p3TT
	 FicZ13/ExX0a1E9JTE3NDGz1RPCQ6clamKEQnaR1k8Brsbt0hv4YmfvUjfvXnGeaMA
	 76WJybkwdTKKZJiCuFCNyaIdInD6tdSdEgnAD0YMrE6xYORIwbu6fuUNPkodPbOF4f
	 qlTSgpJnwSqtA==
Message-ID: <sashiko-outbox-189855@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 3/3] selftests: net: add tests for saddr, anycast
 and loopback subnets
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@riseup.net>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261028191103.623156-4-ihuguet@riseup.net>
References: <20261028191103.623156-1-ihuguet@riseup.net>
 <20261028191103.623156-4-ihuguet@riseup.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 19:12:47 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [Medium] selftests: net: race between UDP send and addr del in test_remov=
e_addr_tcp_udp()
- [Medium] selftests: net: missing IPv6 FIB rule in setup_loopback_subnets()
- [Medium] selftests: net: ip_saddr IPV6_PKTINFO bypasses routing saddr che=
ck in UDPv6 tests
- [Medium] selftests: net: ip_saddr hdrincl tests never exercise FLOWI_FLAG=
_ANYSRC check
- [Medium] selftests: net: subshell RET loss and custom loops in wait_addr_=
missing()
- [Low] selftests: net: missing sockaddr cast in send_or_receive_hdrincl()
--

commit ac326b57c470225e1a2b925bc997e96e565c7e5a
Author: =C3=8D=C3=B1igo Huguet <ihuguet@riseup.net>

selftests: net: add tests for saddr, anycast and loopback subnets

This commit adds networking selftests covering outgoing packet source addre=
ss
validation for IPv4 and IPv6 across TCP, UDP, and raw sockets with HDRINCL,
along with tests for IPv6 anycast and loopback subnets.

> diff --git a/tools/testing/selftests/net/ip_saddr.c b/tools/testing/selft=
ests/net/ip_saddr.c
> new file mode 100644
> index 0000000000000..ed9b0a360b281
> --- /dev/null
> +++ b/tools/testing/selftests/net/ip_saddr.c
> @@ -0,0 +1,557 @@
[ ... ]
> +static int create_sock_ipv6(int proto, int port, bool transparent)
> +{
> +	struct sockaddr_in6 address;
> +	int sk, opt;
[ ... ]
> +	opt =3D 1;
> +	if (setsockopt(sk, IPPROTO_IPV6, IPV6_RECVPKTINFO, &opt, sizeof(opt))) {
> +		perror("Failed to set IPV6_PKTINFO");
> +		exit(EXIT_FAILURE);
> +	}
> +	opt =3D 1;
> +	if (transparent &&
> +	    setsockopt(sk, IPPROTO_IPV6, IPV6_TRANSPARENT, &opt, sizeof(opt))) {
> +		perror("Failed to set IPV6_TRANSPARENT");
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	memset(&address, 0, sizeof(address));
> +	address.sin6_family =3D AF_INET6;
> +	address.sin6_addr =3D in6addr_any;
> +	address.sin6_port =3D htons(port);
> +
> +	if (bind(sk, (struct sockaddr *)&address, sizeof(address))) {
> +		perror("Failed to bind");
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	return sk;
> +}
[ ... ]
> +static void wait_and_send_udp(int sk, int sync_fd)
> +{
> +	uint8_t data_buff[256], ctrl_buff[256];
> +	ssize_t nbytes;
[ ... ]
> +	nbytes =3D recvmsg(sk, &msg, 0);
> +	if (nbytes < 0) {
> +		perror("Failed to receive");
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	// The "test_foreign_addr_*" tests needs us to reply to the same address
> +	// but different port, and also from a different local address. The new
> +	// saddr and dport are received in the previous message with the format
> +	// "new_source_address new_dest_port"
> +	data_buff[nbytes] =3D '\0';
> +	maybe_chg_saddr_dport((char *)data_buff, &msg);
> +
> +	sync_wait(sync_fd);
> +
> +	// Change the data, but keep the same ancillary data so that we use the
> +	// same addresses as we received.
> +	iov.iov_base =3D MESSAGE;
> +	iov.iov_len =3D strlen(MESSAGE);
> +
> +	if (sendmsg(sk, &msg, 0) < 0) {
> +		/* Contrary to the TCP case, as UDP doesn't keep a "connection",
> +		 * the test cases where the source address is not configured in
> +		 * the host return an error here. It is expected, ignore it.
> +		 */
> +	}
> +}

[Severity: Medium]
Does passing the IPV6_PKTINFO control message to sendmsg() in
wait_and_send_udp() bypass the new routing source address check in
ip6_dst_lookup_tail() during the negative IPv6 UDP tests?

In create_sock_ipv6(), the UDP socket is bound to in6addr_any with
IPV6_RECVPKTINFO enabled, and wait_and_send_udp() passes the received
IPV6_PKTINFO control message back into sendmsg(sk, &msg, 0).

In the kernel, udpv6_sendmsg() calls ip6_datagram_send_ctl() when
msg->msg_controllen is non-zero. For a non-transparent socket
(!ipv6_can_nonlocal_bind()), ip6_datagram_send_ctl() validates
src_info->ipi6_addr via ipv6_chk_addr_and_flags() and
ipv6_chk_acast_addr_src(), returning -EINVAL immediately when the address h=
as
been removed, expired, or replaced with FOREIGN_ADDR6.

Because udpv6_sendmsg() aborts during cmsg parsing before calling
ip6_sk_dst_lookup_flow() -> ip6_dst_lookup_tail() -> ip6_is_local_saddr(),
test_remove_addr_ipv6_udp_normal, test_expire_addr_ipv6_udp_normal, and
test_foreign_addr_ipv6_udp_normal will pass even on a kernel without the
ip6_dst_lookup_tail() change. Should the UDP socket instead bind or connect=
 to
the source address so that fl6->saddr is populated from np->saddr and check=
ed
in ip6_dst_lookup_tail()?

> +
> +/* -----------------------------------------------
> + * Functions for the HDRINCL tests:
> + * - Create a RAW socket with the HDRINCL sockopt
> + * - If acting as server, wait for incoming data and print it
> + * - If acting as client, craft a packet with the saddr and daddr from t=
he args
> + *   and send it.
> + * ------------------------------------------------
> + */
> +static int create_sock_ipv4_hdrincl(void)
> +{
> +	struct sockaddr_in address;
> +	int sk, opt;
[ ... ]
> +	memset(&address, 0, sizeof(address));
> +	address.sin_family =3D AF_INET;
> +	address.sin_addr.s_addr =3D htonl(INADDR_ANY);
> +
> +	if (bind(sk, (struct sockaddr *)&address, sizeof(address))) {
> +		perror("Failed to bind");
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	return sk;
> +}
> +
> +static int create_sock_ipv6_hdrincl(void)
> +{
> +	struct sockaddr_in6 address;
> +	int sk, opt;
[ ... ]
> +	memset(&address, 0, sizeof(address));
> +	address.sin6_family =3D AF_INET6;
> +	address.sin6_addr =3D in6addr_any;
> +
> +	if (bind(sk, (struct sockaddr *)&address, sizeof(address))) {
> +		perror("Failed to bind");
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	return sk;
> +}

[Severity: Medium]
Do the HDRINCL raw socket tests actually exercise the FLOWI_FLAG_ANYSRC che=
ck
during route lookup?

Both create_sock_ipv4_hdrincl() and create_sock_ipv6_hdrincl() bind the raw
socket to INADDR_ANY and in6addr_any, and send_or_receive_hdrincl() calls
sendto() without a PKTINFO control message, placing local_addr only inside =
the
user-crafted packet buffer. In addition, test_remove_addr_hdrincl() and
test_expire_addr_hdrincl() in ip_saddr.sh delete or expire SENDER_ADDR befo=
re
starting the client ip_saddr process.

In the kernel, raw_sendmsg() and rawv6_sendmsg() perform the route lookup
(ip_route_output_flow() and ip6_dst_lookup_flow()) before raw_send_hdrinc()=
 or
rawv6_send_hdrinc() copies the IP header from userspace. During that route
lookup, fl4.saddr and fl6.saddr are taken from inet->inet_saddr and np->sad=
dr
(which are 0.0.0.0 and ::), so the route lookup selects the valid permanent
CLI_ADDR4 or CLI_ADDR6 configured on eth0 rather than testing an invalidated
or foreign source address against FLOWI_FLAG_ANYSRC.

Should the raw socket bind to SENDER_ADDR before the address is removed or
expired (or pass local_addr via IP_PKTINFO / IPV6_PKTINFO) so that fl4.saddr
and fl6.saddr hold the invalidated or foreign address when entering route
lookup?

[ ... ]
> +static void send_or_receive_hdrincl(int sk,
> +				    bool is_ipv6,
> +				    bool send_msg,
> +				    union addr46 *local_addr,
> +				    union addr46 *peer_addr)
> +{
> +	uint8_t buff[256];
> +	ssize_t msglen;
> +
> +	if (send_msg && is_ipv6) {
> +		struct sockaddr_in6 dest;
> +
> +		memset(&dest, 0, sizeof(dest));
> +		dest.sin6_family =3D AF_INET6;
> +		dest.sin6_addr =3D peer_addr->addr6;
> +		msglen =3D create_packet_ipv6(buff,
> +					    local_addr->addr6,
> +					    peer_addr->addr6);
> +		if (sendto(sk, buff, msglen, 0, &dest, sizeof(dest)) < 0) {
> +			perror("Failed to send");
> +			exit(EXIT_FAILURE);
> +		}
> +	} else if (send_msg && !is_ipv6) {
> +		struct sockaddr_in dest;
> +
> +		memset(&dest, 0, sizeof(dest));
> +		dest.sin_family =3D AF_INET;
> +		dest.sin_addr =3D peer_addr->addr4;
> +		msglen =3D create_packet_ipv4(buff,
> +					    local_addr->addr4,
> +					    peer_addr->addr4);
> +		if (sendto(sk, buff, msglen, 0, &dest, sizeof(dest)) < 0) {

[Severity: Low]
Will passing &dest (of type struct sockaddr_in6 * and struct sockaddr_in *)
directly to sendto() without casting to (struct sockaddr *)&dest fail to bu=
ild
with -Werror=3Dincompatible-pointer-types on non-glibc C libraries such as =
musl
that do not use a transparent union for struct sockaddr?

[ ... ]
> diff --git a/tools/testing/selftests/net/ip_saddr.sh b/tools/testing/self=
tests/net/ip_saddr.sh
> new file mode 100755
> index 0000000000000..9345b743afd0b
> --- /dev/null
> +++ b/tools/testing/selftests/net/ip_saddr.sh
> @@ -0,0 +1,575 @@
[ ... ]
> +wait_raw_sock_listen_any_addr() {
> +	local ipvx=3D"$1"
> +	local ns=3D"$2"
> +	local ptrn proto found i
> +
> +	if [ "$ipvx" =3D "ipv4" ]; then
> +		ptrn=3D'^00000000:'
> +		proto=3Draw
> +	elif [ "$ipvx" =3D "ipv6" ]; then
> +		ptrn=3D'^00000000000000000000000000000000:'
> +		proto=3Draw6
> +	else
> +		RET=3D$ksft_fail
> +		return 1
> +	fi
> +	for i in $(seq 10); do
> +		found=3D"$(ip netns exec "$ns" cat "/proc/net/$proto" | \
> +			awk -vptrn=3D"$ptrn" '$2 ~ ptrn {print "yes"}')"
> +		[ "$found" =3D "yes" ] && return 0
> +		sleep 0.1
> +	done
> +	RET=3D$ksft_fail
> +	return 1
> +}
> +
> +wait_addr_missing() {
> +	local ns=3D"$1"
> +	local iface=3D"$2"
> +	local addr=3D"$3"
> +	local timeout=3D"${4:-1}"
> +
> +	for i in $(seq $((timeout * 10))); do
> +		ip -n "$ns" -br a show dev "$iface" | grep -q "$addr" || return 0
> +		sleep 0.1
> +	done
> +	RET=3D$ksft_fail
> +	return 1
> +}

[Severity: Medium]
When wait_addr_missing() is called inside the command substitution and child
bash -c process in test_remove_addr_tcp_udp() and test_expire_addr_tcp_udp(=
),
isn't the RET=3D$ksft_fail assignment lost if the wait times out?

Because ksft_fail is not exported in lib.sh and wait_addr_missing() runs in=
 a
subshell without its return status being checked, a timeout in
wait_addr_missing() will not update RET in the parent shell. In the
transparent socket tests (such as test_expire_addr_ipv4_tcp_transparent), t=
he
subshell will still write to SRV_SYNC_FILE and receive the server's message
while the address is still present, resulting in a false pass.

Also, could wait_raw_sock_listen_any_addr() and wait_addr_missing() reuse
slowwait or busywait from tools/testing/selftests/net/lib.sh instead of open
coding the polling loops?

[ ... ]
> +# Open a TCP/UDP connection to the server, remove the address from the s=
erver
> +# and wait for a message from it. As the address is no longer present, t=
he
> +# expectation is not to receive the message, except for transparent sock=
ets.
> +test_remove_addr_tcp_udp() {
> +	local test_name=3D"$1"
> +	local ipvx=3D"$2"
> +	local proto=3D"$3"
> +	local sock_type=3D"$4"
> +	local srv_msg
> +
> +	setup_test_tcp_udp "$ipvx" "$proto" "$sock_type" "$SRV_SYNC_FILE"
> +	srv_msg=3D"$(ip netns exec $ns_cli bash -c "
> +                        exec 3<>'/dev/$proto/${SENDER_ADDR%/*}/$PORT'
> +                        [ '$proto' =3D 'udp' ] && echo 'x' >&3
> +                        ip -n $ns_srv addr del '$SENDER_ADDR' dev eth0
> +                        wait_addr_missing '$ns_srv' eth0 '$SENDER_ADDR'
> +                        echo 'x' > '$SRV_SYNC_FILE'
> +                        timeout 2s cat <&3
> +                        exec 3<&-
> +                ")"
> +	set_test_result "$sock_type" "yes" "$srv_msg"
> +	cleanup_test
> +	log_test "$test_name"
> +}

[Severity: Medium]
Can "ip -n $ns_srv addr del '$SENDER_ADDR' dev eth0" in
test_remove_addr_tcp_udp() race with the delivery of the initial UDP datagr=
am
to the server?

Unlike TCP, where opening /dev/tcp/... blocks until ARP or NDISC resolution
and the three-way handshake complete with wait_and_send_tcp() in ns_srv,
opening /dev/udp/... only performs a local connect() syscall, and
"echo 'x' >&3" returns as soon as the datagram is queued (including while
waiting for ARP or neighbor discovery resolution).

Furthermore, parse_tcp_udp_args() in ip_saddr.c opens SRV_SYNC_FILE with
O_RDWR at startup before calling recvmsg(), so writing to SRV_SYNC_FILE does
not wait for the server to finish recvmsg() either. If SENDER_ADDR is delet=
ed
on ns_srv before ARP/ND resolution or UDP reception completes, the client's
initial datagram is dropped, wait_and_send_udp() remains blocked in recvmsg=
(),
and test_remove_addr_ipv4_udp_transparent and
test_remove_addr_ipv6_udp_transparent time out and fail (while the normal
variants pass without exercising sendmsg()).

Should wait_and_send_udp() signal the client after recvmsg() succeeds before
the client deletes SENDER_ADDR?

[ ... ]
> diff --git a/tools/testing/selftests/net/loopback_subnet.sh b/tools/testi=
ng/selftests/net/loopback_subnet.sh
> new file mode 100755
> index 0000000000000..c846e65f01f3b
> --- /dev/null
> +++ b/tools/testing/selftests/net/loopback_subnet.sh
> @@ -0,0 +1,135 @@
[ ... ]
> +setup_loopback_subnets() {
> +        local rt_table=3D"${1:-local}"
> +
> +        ip -n $ns_srv route add local "$LO_SUBNET4" dev lo table "$rt_ta=
ble"
> +        ip -n $ns_srv route add local "$LO_SUBNET6" dev lo table "$rt_ta=
ble"
> +        if [[ $rt_table !=3D local && $rt_table !=3D 255 ]]; then
> +                ip -n $ns_srv rule add from all lookup "$rt_table"
> +        fi
> +}
> +
> +cleanup_loopback_subnets() {
> +        local rt_table=3D"${1:-local}"
> +
> +        ip -n $ns_srv route del local "$LO_SUBNET4" dev lo table "$rt_ta=
ble"
> +        ip -n $ns_srv route del local "$LO_SUBNET6" dev lo table "$rt_ta=
ble"
> +        if [[ $rt_table !=3D local && $rt_table !=3D 255 ]]; then
> +                ip -n $ns_srv rule del from all lookup "$rt_table"
> +        fi
> +}

[Severity: Medium]
Aren't setup_loopback_subnets() and cleanup_loopback_subnets() missing "-6"
rule commands for IPv6?

In setup_loopback_subnets(), "ip -n $ns_srv route add local $LO_SUBNET6 ..."
automatically selects AF_INET6 because LO_SUBNET6 is an IPv6 prefix, but
"ip -n $ns_srv rule add from all lookup $rt_table" has no address family
indicator and defaults to IPv4 (AF_INET) only.

Without "ip -6 -n $ns_srv rule add from all lookup $rt_table" (and the
matching "ip -6 ... rule del" in cleanup_loopback_subnets()), IPv6 FIB
lookups in ns_srv never consult RT_TABLE (200), causing
test_loopback_subnet_from_localhost_ipv6_table and
test_loopback_subnet_from_remote_ipv6_table to fail due to a missing FIB ru=
le
rather than testing loopback subnet behavior in custom tables.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028191103.6231=
56-1-ihuguet@riseup.net?part=3D3
