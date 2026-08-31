Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32B73CAA2F;
	Mon, 31 Aug 2026 17:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788195839; cv=none; b=G7MLjswwPRBddgc/E7zQp5RW2IGiTxDZpk8pmzfBrg35klrKg03icB1c0eQ6q0/UoDzKF2VXJSRIKAyEuKJ40cJ0dfh5ncrJY/+X0Wrkp5E1+JdT0R2645BgyVnXZJE4g7gniF8zLMog/EThw/nqZ4C7TIyGja8HUjGjYidn50E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788195839; c=relaxed/simple;
	bh=g6NyqAwK76SoXBhy5NwD2ihEmCWp3s1VsHypeuec0pA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IGktqrGUEuTkoNEdhq+3pxopXVmkf/aGQ4phs8SF3Z7WwoDK+V2pdyAuyIBJOBaeUPW9F/1xLdxJBcHEvMw82LS5ZF/8rD1yg1RuejG6IHbYz5LH4prb8hvC/JAYd4+tV7H5DUTrealLTtpeQ7T5bK06LUZ8MJ5YVjjQVHo0gs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=t.fuechsel@gmx.de header.b=eTKge0zT; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=t.fuechsel@gmx.de header.b="eTKge0zT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1788195834; x=1788800634; i=t.fuechsel@gmx.de;
	bh=NVvxTQZ8N6dYRJ3OU99H6FEfBdY9lfmnFt9jjEUfHfg=;
	h=X-UI-Sender-Class:Date:From:To:Subject:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=eTKge0zTAzSRJgbV3E7SBImz7efFqw/XiWgKWetkjWg57CKFymBBJClJd0WpNjBQ
	 JEk6TVl2e3NKh/r/pm6OBTYvLIqDxAsozusZH8cbYigNWL2px5RAHY2RStNI8sZ67
	 9E4Vt5TxuBfhC3rEs1K2rSRr9GFhl3wSaik841w8q7FN45wwam/qKxz9R0nHAhCgH
	 5qHPxt/D574kgiQtLR66GwtmOq6uKhKkL4hTMLPB2CA97daNk12/NKPuoW8XN/FmK
	 CiYeQEp0/PZjR2OPAh4YT91U+HOT2dpKz+67anV4baDlN8tP/bIj53SfdxNCn2cPR
	 BW8zqODnldwhQcPVEA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MMGRK-1xICpr2CD0-00XDl8; Mon, 31
 Aug 2026 19:03:54 +0200
Date: Mon, 31 Aug 2026 19:03:50 +0200
From: Tim Fuechsel <t.fuechsel@gmx.de>
To: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, fmancera@suse.de, ebiggers@kernel.org,
	bpf@vger.kernel.org,
	Lukas Prause <lukas.prause@ikt.uni-hannover.de>,
	Tim Fuechsel <t.fuechsel@gmx.de>
Subject: [PATCHv5 net-next] tcp: Add TCP ROCCET congestion control module.
Message-ID: <apWz9rPcGMgYCKOR@volt-roccet-vm>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tJVsFEGHZtJNaEkvyitYMlc1TxiQXt+bST2Bk5x6mF1nT2XIo7u
 7UDOKoFbTQegnfLqliK1MkXIPb6VePt+w0U8dtzWBg7GiE82Us9+r/ABVt/ll2G9uVQUieg
 fASixxpmt9YsmSBDzIlFF7W+fe8b46pvRNCflcfX/Fjvom1d/1zPw62cKHk/gqVXt9daZAw
 CxMbu71J9mxNTqvn6PPHw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8ytDTczOxkY=;Qy4+p4QIuDN1SMRBRkJZyrBQtXU
 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
 vVIerZVP1YE=

TCP ROCCET is an new congestion control algorithm based on TCP CUBIC
that improves its overall performance in cellular networks. By its mode
of function, CUBIC causes bufferbloat while it tries to detect the
available throughput of a network path. This is particularly a problem
with large buffers in mobile networks. A more detailed description and
analysis of this problem caused by TCP CUBIC can be found in [1].
TCP ROCCET addresses the bufferbloat problem by adding two additional
metrics to detect bufferbloat. The first metric is the relative increase
in RTT from its minimum, the srRTT. Here, bufferbloat can be detected
when RTTs increase due to buffer filling. The second metric is the
acknowledgment arrival rate sampled over 100ms intervals. If CUBIC
increases the send rate or congestion window, and the acknowledgment
arrival rate stays on the same level, the connection is limited by the
bottleneck link's capacity. In such cases, ROCCET reduces the send rate
to prevent bufferbloat. ROCCET uses a modified version of slow start
rather than HyStart because HyStart is known to enter the congestion
avoidance phase too early when used in cellular networks [2]. Therefore,
ROCCET uses a combination of srRTT and the acknowledgment arrival rate to
determine when to exit slow start. For the congestion avoidance phase,
ROCCET relies on the srRTT and monitoring the send and received Bytes
to detect the filling of the bottleneck buffer.

In real-world mobile 5G NR measurements, TCP ROCCET achieves better
performance than CUBIC and BBRv3, by maintaining similar throughput
while reducing the latency. In stationary 5G NR scenarios, the performance
is similar to that of BBRv3. More information about TCP ROCCET and
measurement evaluations can be found here [3].
For the version (2026-07-21) we provide additional performance
evaluation regarding throughput, latency and bandwidth share [4].

[1] https://doi.org/10.1109/VTC2023-Fall60731.2023.10333357
[2] https://doi.org/10.1109/WMNC.2016.7543932
[3] https://doi.org/10.23919/WONS68803.2026.11501781
[4] http://go.lu-h.de/roccet-2026-07-21

Signed-off-by: Lukas Prause <lukas.prause@ikt.uni-hannover.de>
Signed-off-by: Tim Fuechsel <t.fuechsel@gmx.de>

=2D--

Changes since v1:
	* Adjust some comments & Rework commit message
	* Fix Kconfig format
	* Add div-by-0 check variables
	* Fix ack summation from +=3D1 to +=3Dacked (counting now ACKs instead of=
 ACK events)
	* Fix wrapping in time comparisons
	* Remove most module_params, including 'ignore_loss'
	* Remove check that always evaluated to 'true' regarding 'bw_limit_detect=
'

Changes since v2:
	* Improve initialization of roccettcp struct
	* Always react to ECE bits and reset flag
	* Detect plateaus in ACK-rate
	* Fix potential overflow in ACK-rate tracking for high-speed connections
	* Reset ACK-counter correctly on new interval
	* Fix potential integer overflow in rRTT calculation

Changes since v3:
	* Changes in comments & Kconfig help text
	* Adjust commit message, adding reference to new performance evaluation
	* Add minimum RTT probing
	* Use cong_control callback instead of cong_avoid
	* Move CA_EVENT_TX_START event check to dedicated callback (cwnd_event_tx=
_start)
	* Add monitoring of send and receive rate as mentioned in the original pa=
per
	* Refactor of the code
	* Remove kfunc exports
	* Fix potential overflow in rRTT calculation by using 64-bit arithmetic
	* Fix potential division-by-zero in srRTT calculation due to RTT value
	* Initialize ack_rate timestamp to current time
	* Fix potential double penalty when receiving ECN (ECE) mark
	* Reset ack counting when connection goes idle
	* Add module-parameter bounds check on register

Changes since v4:
	* Remove __always_inline annotations & unused function
	* Fix module parameter bounds check desync
	* Add idle-check to fix connection freezing
	* Exchange .ssthresh callback from recalc_ssthresh to a ssthresh-getter, =
fixing double penalties
	* Remove unnecessary seq-no wrapping check & Remove 0 as 'uninitialized' =
seq-no value
	* Wait for first control round to finish before starting to monitor poten=
tial slow-start exit conditions
=2D--
 net/ipv4/Kconfig      |   12 +
 net/ipv4/Makefile     |    1 +
 net/ipv4/tcp_roccet.c | 1050 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 1063 insertions(+)
 create mode 100644 net/ipv4/tcp_roccet.c

diff --git a/net/ipv4/Kconfig b/net/ipv4/Kconfig
index 301b47660305..3545fb0a045b 100644
=2D-- a/net/ipv4/Kconfig
+++ b/net/ipv4/Kconfig
@@ -663,6 +663,18 @@ config TCP_CONG_CDG
 	    delay gradients." In Networking 2011. Preprint:
 	    http://caia.swin.edu.au/cv/dahayes/content/networking2011-cdg-prepri=
nt.pdf
=20
+config TCP_CONG_ROCCET
+	tristate "ROCCET TCP"
+	default n
+	help
+	  TCP ROCCET (RTT oriented CUBIC congestion control exTension) is a
+	  sender-side-only congestion control algorithm based on the TCP CUBIC
+	  protocol stack/TCP CUBIC congestion control algorithm that optimizes
+	  its performance. Especially for networks with large buffers
+	  (wireless, cellular networks), TCP ROCCET has improved performance by
+	  maintaining a similar throughput as CUBIC while reducing latency.
+	  For more information, see: https://arxiv.org/abs/2510.25281
+
 config TCP_CONG_BBR
 	tristate "BBR TCP"
 	default n
diff --git a/net/ipv4/Makefile b/net/ipv4/Makefile
index 06e21c26b76f..69e4baaed122 100644
=2D-- a/net/ipv4/Makefile
+++ b/net/ipv4/Makefile
@@ -45,6 +45,7 @@ obj-$(CONFIG_INET_TCP_DIAG) +=3D tcp_diag.o
 obj-$(CONFIG_INET_UDP_DIAG) +=3D udp_diag.o
 obj-$(CONFIG_INET_RAW_DIAG) +=3D raw_diag.o
 obj-$(CONFIG_TCP_CONG_BBR) +=3D tcp_bbr.o
+obj-$(CONFIG_TCP_CONG_ROCCET) +=3D tcp_roccet.o
 obj-$(CONFIG_TCP_CONG_BIC) +=3D tcp_bic.o
 obj-$(CONFIG_TCP_CONG_CDG) +=3D tcp_cdg.o
 obj-$(CONFIG_TCP_CONG_CUBIC) +=3D tcp_cubic.o
diff --git a/net/ipv4/tcp_roccet.c b/net/ipv4/tcp_roccet.c
new file mode 100644
index 000000000000..18925a79bd8d
=2D-- /dev/null
+++ b/net/ipv4/tcp_roccet.c
@@ -0,0 +1,1050 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * TCP ROCCET: An RTT-Oriented CUBIC Congestion Control
+ * Extension for 5G and Beyond Networks
+ *
+ * TCP ROCCET is a new TCP congestion control
+ * algorithm suited for current cellular 5G NR beyond networks.
+ * It extends the kernel default congestion control CUBIC
+ * and improves its performance, and additionally solves an
+ * unwanted side effects of CUBIC=E2=80=99s implementation.
+ * ROCCET uses its own Slow Start, called LAUNCH, where loss
+ * is not considered as a congestion event.
+ * The congestion avoidance phase, called ORBITER, uses
+ * CUBIC's window growth function and adds, based on RTT
+ * and ACK rate, congestion events.
+ *
+ * A peer-reviewed paper on TCP ROCCET will be presented
+ * at the WONS 2026 conference.
+ * A draft of the paper is available here:
+ *		https://arxiv.org/abs/2510.25281
+ *
+ *
+ * Further information about CUBIC:
+ * TCP CUBIC: Binary Increase Congestion control for TCP v2.3
+ * Home page:
+ *	http://netsrv.csc.ncsu.edu/twiki/bin/view/Main/BIC
+ * This is from the implementation of CUBIC TCP in
+ * Sangtae Ha, Injong Rhee and Lisong Xu,
+ *  "CUBIC: A New TCP-Friendly High-Speed TCP Variant"
+ *  in ACM SIGOPS Operating System Review, July 2008.
+ * Available from:
+ *  http://netsrv.csc.ncsu.edu/export/cubic_a_new_tcp_2008.pdf
+ *
+ * CUBIC integrates a new slow start algorithm, called HyStart.
+ * The details of HyStart are presented in
+ *  Sangtae Ha and Injong Rhee,
+ *  "Taming the Elephants: New TCP Slow Start", NCSU TechReport 2008.
+ * Available from:
+ *  http://netsrv.csc.ncsu.edu/export/hystart_techreport_2008.pdf
+ *
+ * All testing results are available from:
+ * http://netsrv.csc.ncsu.edu/wiki/index.php/TCP_Testing
+ *
+ * Unless CUBIC is enabled and congestion window is large
+ * this behaves the same as the original Reno.
+ */
+
+#include <linux/printk.h>
+#include <linux/math64.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <net/tcp.h>
+
+/* Scale factor beta calculation (max_cwnd =3D snd_cwnd * beta) */
+#define BICTCP_BETA_SCALE 1024
+
+#define BICTCP_HZ 10 /* BIC HZ 2^10 =3D 1024 */
+
+/* Alpha value for the sRrTT  multiplied by 100.
+ * Here 20 represents a value of 0.2
+ */
+#define ROCCET_ALPHA_TIMES_100 20
+
+/* min RTT probe period in ms */
+#define ROCCET_NEXT_MIN_RTT_PROBE 5000
+
+/* State in which roccet currently operates */
+enum roccet_state {
+	LAUNCH,
+	ORBITER,
+	RTT_PROBE,
+	RTT_PROBE_REFILL,
+	DRAIN
+};
+
+/* TCP ROCCET struct based on the original BICTCP struct with
+ * additions specific to the ROCCET-Algorithm.
+ */
+struct roccettcp {
+	u32 cnt;	/* increase cwnd by 1 after ACKs */
+	u32 last_max_cwnd;	/* last maximum snd_cwnd */
+	u32 last_cwnd;	/* the last snd_cwnd */
+	u32 last_time;	/* time when updated last_cwnd */
+	u32 bic_origin_point;	/* origin point of bic function */
+	u32 bic_K;	/* time to origin point from the
+			 * beginning of the current epoch
+			 */
+	u32 delay_min;	/* min delay (usec) */
+	u32 epoch_start;	/* beginning of an epoch */
+	u32 ack_cnt;	/* number of acks */
+	u32 tcp_cwnd;	/* estimated tcp cwnd */
+	u32 curr_rtt;	/* last sample rtt of current round */
+
+	u32 roccet_last_event_time_us; /* The last time ROCCET was triggered */
+	u32 curr_min_rtt;	/* The current observed minRTT */
+	u32 next_min_rtt_probe;	/* Next time to probe the minRTT */
+	u32 probe_min_rtt_until;	/* End of minRTT probing period */
+	u32 refill_until;	/* End of pipe refill after minRTT probe */
+	u32 cwnd_before_min_rtt_probe;	/* cwnd before min RTT probeing */
+	u32 curr_srrtt;	/* srRTT calculated based on the latest ACK */
+	u32 next_srrtt_check;	/* Next check for srRTT */
+	u32 last_rtt;	/* sample rtt of previous round.
+			 * Used for jitter calculation
+			 */
+
+	u32 interval_snd_seq_start;
+	u32 interval_una_seq_start;
+
+	u32 ack_rate_last_rate_time;	/* Timestamp of the last ACK-rate */
+	u16 ack_rate_last_rate;	/* Last ACK-rate */
+	u16 ack_rate_curr_rate;	/* Current ACK-rate */
+	u16 ack_rate_cnt;	/* Used for counting acks */
+
+	bool ece_received : 1;	/* Set to true if an ECE bit was received */
+	enum roccet_state state : 3; /* Current operating state of roccet */
+	bool was_idle : 1;	/* Tracks whether the connection has was idle
+				 * (had no in-flight packets)
+				 */
+	bool is_in_recovery: 1; /* Tracks whether the latest state was
+				 * TCP_CA_Recovery
+				 */
+	bool initial_round_completed: 1; /* Set to true after the initial
+					  * roccet-control round has completed
+					  */
+};
+
+/* Parameters that are specific to the ROCCET-Algorithm */
+
+// =3D 717/1024 (BICTCP_BETA_SCALE)
+#define BETA_PARAM_DEFAULT 717
+#define BIC_SCALE_PARAM_DEFAULT 41
+
+static uint sr_rtt_upper_bound __read_mostly =3D 100;
+static int ack_rate_diff_ss __read_mostly =3D 10;
+
+module_param(sr_rtt_upper_bound, uint, 0644);
+MODULE_PARM_DESC(sr_rtt_upper_bound, "ROCCET's upper bound for srRTT.");
+module_param(ack_rate_diff_ss, int, 0644);
+MODULE_PARM_DESC(ack_rate_diff_ss,
+		 "ROCCET's threshold to exit slow start if ACK-rate defer by given amou=
nt of segments.");
+
+static int fast_convergence __read_mostly =3D 1;
+static int beta_param __read_mostly =3D BETA_PARAM_DEFAULT;
+static int beta __read_mostly;
+static int initial_ssthresh __read_mostly;
+static int bic_scale_param __read_mostly =3D BIC_SCALE_PARAM_DEFAULT;
+static int bic_scale __read_mostly;
+static int tcp_friendliness __read_mostly =3D 1;
+
+static u32 cube_rtt_scale __read_mostly;
+static u32 beta_scale __read_mostly;
+static u64 cube_factor __read_mostly;
+
+/* Note parameters that are used for precomputing scale factors are read-=
only */
+module_param(fast_convergence, int, 0644);
+MODULE_PARM_DESC(fast_convergence, "turn on/off fast convergence");
+module_param(beta_param, int, 0644);
+MODULE_PARM_DESC(beta_param, "beta for multiplicative increase");
+module_param(initial_ssthresh, int, 0644);
+MODULE_PARM_DESC(initial_ssthresh, "initial value of slow start threshold=
");
+module_param(bic_scale_param, int, 0444);
+MODULE_PARM_DESC(bic_scale_param,
+		 "scale (scaled by 1024) value for bic function (bic_scale/1024)");
+module_param(tcp_friendliness, int, 0644);
+MODULE_PARM_DESC(tcp_friendliness, "turn on/off tcp friendliness");
+
+static void roccettcp_reset(struct roccettcp *ca)
+{
+	memset(ca, 0, sizeof(struct roccettcp));
+	ca->next_srrtt_check =3D 0;
+	ca->curr_min_rtt =3D ~0U;
+	ca->last_rtt =3D 0;
+	ca->ece_received =3D false;
+
+	ca->roccet_last_event_time_us =3D 0;
+	ca->ack_rate_last_rate =3D 0;
+	/* Initialize to current time to avoid an
+	 * overflow in the ack rate calculation
+	 */
+	ca->ack_rate_last_rate_time =3D jiffies_to_usecs(tcp_jiffies32);
+	ca->ack_rate_curr_rate =3D 0;
+	ca->ack_rate_cnt =3D 0;
+
+	/* Start state is LAUNCH */
+	ca->state =3D LAUNCH;
+
+	ca->initial_round_completed =3D false;
+}
+
+static void update_min_rtt(struct sock *sk)
+{
+	struct roccettcp *ca =3D inet_csk_ca(sk);
+
+	/* Check if new lower min RTT was found. If so, set it directly */
+	if (ca->curr_rtt < ca->curr_min_rtt) {
+		ca->curr_min_rtt =3D max(ca->curr_rtt, 1);
+		/* Probe for the min RTT in ROCCET_NEXT_MIN_RTT_PROBE seconds
+		 * if no other update occurs.
+		 */
+		ca->next_min_rtt_probe =3D
+			jiffies_to_usecs(tcp_jiffies32) +
+			ROCCET_NEXT_MIN_RTT_PROBE * USEC_PER_MSEC;
+	}
+}
+
+/* Return difference between last and current ack rate.
+ */
+static s32 get_ack_rate_diff(struct roccettcp *ca)
+{
+	if (ca->ack_rate_curr_rate < ca->ack_rate_last_rate)
+		return 0;
+	return (s32)(ca->ack_rate_curr_rate - ca->ack_rate_last_rate);
+}
+
+/* Update ack rate sampled by 100ms.
+ */
+static void update_ack_rate(struct sock *sk, u32 acked, u32 now)
+{
+	struct roccettcp *ca =3D inet_csk_ca(sk);
+	s32 interval =3D USEC_PER_MSEC * 100;
+
+	s32 time_delta =3D (s32)(ca->ack_rate_last_rate_time - now);
+	const s32 idle_threshold =3D USEC_PER_SEC * 2;
+
+	/* Check if the time has arrived in the new interval.
+	 * Alternatively if the connection was considered to be idle,
+	 * also treat as a new interval in order to avoid timing-overflow
+	 * problems.
+	 */
+	if (time_delta < -interval || ca->was_idle) {
+		/* Check if the connection was idle for X seconds
+		 * (e.g. no ACK for X seconds)
+		 */
+		if (time_delta < -idle_threshold) {
+			/* Reset ack counting as if a new
+			 * connection was created
+			 */
+			ca->ack_rate_last_rate =3D 0;
+			ca->ack_rate_last_rate_time =3D
+				jiffies_to_usecs(tcp_jiffies32);
+			ca->ack_rate_curr_rate =3D 0;
+			ca->ack_rate_cnt =3D 0;
+		} else {
+			ca->ack_rate_last_rate_time =3D now;
+			ca->ack_rate_last_rate =3D ca->ack_rate_curr_rate;
+			ca->ack_rate_curr_rate =3D ca->ack_rate_cnt;
+			ca->ack_rate_cnt =3D
+				acked; // start counting for the new interval
+		}
+
+		ca->was_idle =3D false;
+	} else {
+		// Cap the ack count to avoid overflow
+		ca->ack_rate_cnt =3D min_t(u32, ca->ack_rate_cnt + acked,
+					 U16_MAX);
+	}
+}
+
+/* Compute srRTT.
+ */
+static void update_srrtt(struct sock *sk)
+{
+	struct roccettcp *ca =3D inet_csk_ca(sk);
+
+	/* Avoid integer overflow in the calculation below.
+	 * This could occur in cases where we have not yet
+	 * received an RTT sample. In these cases, set the
+	 * rtt to a safe value.
+	 */
+	if (ca->curr_rtt < ca->curr_min_rtt) {
+		ca->curr_rtt =3D max(ca->curr_rtt, 1);
+		ca->curr_min_rtt =3D ca->curr_rtt;
+	}
+
+	/* Avoid division by zero */
+	if (ca->curr_min_rtt =3D=3D 0) {
+		ca->curr_min_rtt =3D max(ca->curr_min_rtt, 1);
+		return; // skip srRTT update
+	}
+
+	/* Calculate the new rRTT (Scaled by 100).
+	 * 100 * ((sRTT - sRTT_min) / sRTT_min).
+	 *
+	 * curr_min_rtt_timed.rtt is always <=3D than curr_rtt,
+	 * since this is the minimum of the rtt.
+	 *
+	 * 0 is a valid value for rrtt.
+	 */
+	u32 rrtt =3D div_u64(100 * (u64)(ca->curr_rtt - ca->curr_min_rtt),
+			   ca->curr_min_rtt);
+
+	// (1 - alpha) * srRTT + alpha * rRTT
+	ca->curr_srrtt =3D ((100 - ROCCET_ALPHA_TIMES_100) * ca->curr_srrtt +
+			  ROCCET_ALPHA_TIMES_100 * rrtt) /
+			 100;
+}
+
+/* Do a ROCCET congestion event.
+ */
+static void roccet_congestion_event(struct sock *sk, u32 now)
+{
+	struct tcp_sock *tp =3D tcp_sk(sk);
+	struct roccettcp *ca =3D inet_csk_ca(sk);
+
+	ca->epoch_start =3D 0;
+	ca->roccet_last_event_time_us =3D now;
+	ca->cnt =3D 100 * tcp_snd_cwnd(tp);
+	/*Set W_max only if the current cwnd is larger */
+	if (tcp_snd_cwnd(tp) > ca->last_max_cwnd)
+		ca->last_max_cwnd =3D tcp_snd_cwnd(tp);
+	tcp_snd_cwnd_set(tp,
+			 min(tp->snd_cwnd_clamp,
+			     max((tcp_snd_cwnd(tp) * beta)
+				 / BICTCP_BETA_SCALE, 2U)));
+	tp->snd_ssthresh =3D tcp_snd_cwnd(tp);
+}
+
+/* Do minimum RTT probing.
+ */
+static void roccet_min_rtt_probe(struct sock *sk, u32 now)
+{
+	struct tcp_sock *tp =3D tcp_sk(sk);
+	struct roccettcp *ca =3D inet_csk_ca(sk);
+	u32 interval, probe_cwnd;
+
+	/* Do nothing if we are probing */
+	if (before(now, ca->probe_min_rtt_until) && ca->probe_min_rtt_until > 0)
+		return;
+
+	/* Start of min RTT probing*/
+	if (ca->probe_min_rtt_until =3D=3D 0) {
+		/* Probe 1*RTT or at least 200ms */
+		interval =3D max(200 * USEC_PER_MSEC, ca->curr_rtt);
+
+		/* This is to handle deep shared buffers with loss-based
+		 * congestion control like CUBIC. If the cwnd is not limited
+		 * by the application but falsely detected (see ROCCET paper),
+		 * we have to empty the pipe more.
+		 * If the limit detection is correct this will cause no harm
+		 * to the tcp flow because the cwnd is not fully utilized and
+		 * we set the cwnd to its previous value after probing.
+		 */
+		probe_cwnd =3D max(tcp_snd_cwnd(tp) / 2, TCP_INIT_CWND);
+		if (!tcp_is_cwnd_limited(sk))
+			probe_cwnd =3D max(tcp_snd_cwnd(tp) / 3, TCP_INIT_CWND);
+
+		ca->probe_min_rtt_until =3D now + interval;
+		ca->cwnd_before_min_rtt_probe =3D tcp_snd_cwnd(tp);
+
+		/* Half the cwnd to drain the buffer for probing.
+		 * Set the ssthresh to the probing cwnd otherwise
+		 * the TCP state machine is in slow start.
+		 */
+		tcp_snd_cwnd_set(tp, probe_cwnd);
+		tcp_sk(sk)->snd_ssthresh =3D tcp_snd_cwnd(tp);
+
+		/* Reset current min RTT to allow probing for
+		 * a new lower and higher minimum RTT.
+		 */
+		ca->curr_min_rtt =3D ~0U;
+
+		/* Refill the pipe after probing.
+		 * To this end we need the previous cwnd over
+		 * the probing interval.
+		 */
+		ca->refill_until =3D ca->probe_min_rtt_until + interval;
+	} else if (before(now, ca->refill_until)) {
+		/* Reset cwnd and refill the pipe. */
+		if (ca->state !=3D RTT_PROBE_REFILL) {
+			tcp_snd_cwnd_set(tp, ca->cwnd_before_min_rtt_probe);
+			tcp_sk(sk)->snd_ssthresh =3D tcp_snd_cwnd(tp);
+			ca->state =3D RTT_PROBE_REFILL;
+		}
+	} else {
+		/* End min RTT probing phase. */
+		ca->probe_min_rtt_until =3D 0;
+		ca->state =3D ORBITER;
+	}
+}
+
+/* Used to check the roccet params in advance in order to avoid
+ * invalid-param-attacks. This validates the provided params and
+ * then saves valid copies of the params.
+ */
+static int param_check(bool use_defaults)
+{
+	int ret =3D 0;
+
+	/*
+	 * Validate parameters to avoid division by zero errors.
+	 */
+	if (beta_param <=3D 0 || beta_param >=3D BICTCP_BETA_SCALE) {
+		pr_err("roccet: beta must be between 0 and %d\n",
+		       BICTCP_BETA_SCALE);
+
+		if (use_defaults) {
+			pr_info("Using default value of %d for beta.\n",
+				BETA_PARAM_DEFAULT);
+			beta =3D BETA_PARAM_DEFAULT;
+		} else {
+			ret =3D -EINVAL;
+		}
+	} else {
+		beta =3D beta_param;
+	}
+
+	if (bic_scale_param <=3D 0) {
+		pr_err("roccet: bic_scale must be positive\n");
+
+		if (use_defaults) {
+			pr_info("Using default value of %d for bic_scale.\n",
+				BIC_SCALE_PARAM_DEFAULT);
+			bic_scale =3D BIC_SCALE_PARAM_DEFAULT;
+		} else {
+			ret =3D -EINVAL;
+		}
+	} else {
+		bic_scale =3D bic_scale_param;
+	}
+
+	return ret;
+}
+
+/* Precompute some values based on the provided params.
+ */
+static void param_precompute(void)
+{
+	/* Precompute a bunch of the scaling factors that are used per-packet
+	 * based on SRTT of 100ms
+	 */
+	beta_scale =3D
+		8 * (BICTCP_BETA_SCALE + beta) / 3 / (BICTCP_BETA_SCALE - beta);
+
+	cube_rtt_scale =3D (bic_scale * 10); /* 1024*c/rtt */
+
+	/* calculate the "K" for (wmax-cwnd) =3D c/rtt * K^3
+	 *  so K =3D cubic_root( (wmax-cwnd)*rtt/c )
+	 * the unit of K is bictcp_HZ=3D2^10, not HZ
+	 *
+	 *  c =3D bic_scale >> 10
+	 *  rtt =3D 100ms
+	 *
+	 * the following code has been designed and tested for
+	 * cwnd < 1 million packets
+	 * RTT < 100 seconds
+	 * HZ < 1,000,00  (corresponding to 10 nano-second)
+	 */
+
+	/* 1/c * 2^2*bictcp_HZ * srtt */
+	cube_factor =3D 1ull << (10 + 3 * BICTCP_HZ); /* 2^40 */
+
+	/* divide by bic_scale and by constant Srtt (100ms) */
+	do_div(cube_factor, bic_scale * 10);
+}
+
+static void roccettcp_init(struct sock *sk)
+{
+	/* Check & precompute on `init` in order to use the newest
+	 * available params.
+	 */
+	param_check(true);
+	param_precompute();
+
+	struct roccettcp *ca =3D inet_csk_ca(sk);
+
+	roccettcp_reset(ca);
+
+	if (initial_ssthresh)
+		tcp_sk(sk)->snd_ssthresh =3D initial_ssthresh;
+
+	ca->interval_snd_seq_start =3D tcp_sk(sk)->snd_nxt;
+	ca->interval_una_seq_start =3D tcp_sk(sk)->snd_una;
+
+	cmpxchg(&sk->sk_pacing_status, SK_PACING_NONE, SK_PACING_NEEDED);
+	//WRITE_ONCE(sk->sk_pacing_rate, 0);
+}
+
+static void roccettcp_cwnd_event_tx_start(struct sock *sk)
+{
+	struct roccettcp *ca =3D inet_csk_ca(sk);
+	u32 now =3D tcp_jiffies32;
+	s32 delta;
+
+	delta =3D now - tcp_sk(sk)->lsndtime;
+
+	/* We were application limited (idle) for a while.
+	 * Shift epoch_start to keep cwnd growth to cubic curve.
+	 */
+	if (ca->epoch_start && delta > 0) {
+		ca->epoch_start +=3D delta;
+		if (after(ca->epoch_start, now))
+			ca->epoch_start =3D now;
+	}
+
+	ca->was_idle =3D true;
+}
+
+/* calculate the cubic root of x using a table lookup followed by one
+ * Newton-Raphson iteration.
+ * Avg err ~=3D 0.195%
+ */
+static u32 cubic_root(u64 a)
+{
+	u32 x, b, shift;
+	/* cbrt(x) MSB values for x MSB values in [0..63].
+	 * Precomputed then refined by hand - Willy Tarreau
+	 *
+	 * For x in [0..63],
+	 *   v =3D cbrt(x << 18) - 1
+	 *   cbrt(x) =3D (v[x] + 10) >> 6
+	 */
+	static const u8 v[] =3D {
+		/* 0x00 */ 0,	54,  54,  54,  118, 118, 118, 118,
+		/* 0x08 */ 123, 129, 134, 138, 143, 147, 151, 156,
+		/* 0x10 */ 157, 161, 164, 168, 170, 173, 176, 179,
+		/* 0x18 */ 181, 185, 187, 190, 192, 194, 197, 199,
+		/* 0x20 */ 200, 202, 204, 206, 209, 211, 213, 215,
+		/* 0x28 */ 217, 219, 221, 222, 224, 225, 227, 229,
+		/* 0x30 */ 231, 232, 234, 236, 237, 239, 240, 242,
+		/* 0x38 */ 244, 245, 246, 248, 250, 251, 252, 254,
+	};
+
+	b =3D fls64(a);
+	if (b < 7) {
+		/* a in [0..63] */
+		return ((u32)v[(u32)a] + 35) >> 6;
+	}
+
+	b =3D ((b * 84) >> 8) - 1;
+	shift =3D (a >> (b * 3));
+
+	x =3D ((u32)(((u32)v[shift] + 10) << b)) >> 6;
+
+	/* Newton-Raphson iteration
+	 *                         2
+	 * x    =3D ( 2 * x  +  a / x  ) / 3
+	 *  k+1          k         k
+	 */
+	x =3D (2 * x + (u32)div64_u64(a, (u64)x * (u64)(x - 1)));
+	x =3D ((x * 341) >> 10);
+	return x;
+}
+
+/* Compute congestion window to use.
+ */
+static void bictcp_update(struct roccettcp *ca, u32 cwnd,
+			  u32 acked)
+{
+	u32 delta, bic_target, max_cnt;
+	u64 offs, t;
+
+	ca->ack_cnt +=3D acked; /* count the number of ACKed packets */
+
+	if (ca->last_cwnd =3D=3D cwnd &&
+	    (s32)(tcp_jiffies32 - ca->last_time) <=3D HZ / 32)
+		return;
+
+	/* The CUBIC function can update ca->cnt at most once per jiffy.
+	 * On all cwnd reduction events, ca->epoch_start is set to 0,
+	 * which will force a recalculation of ca->cnt.
+	 */
+	if (ca->epoch_start && tcp_jiffies32 =3D=3D ca->last_time)
+		goto tcp_friendliness;
+
+	ca->last_cwnd =3D cwnd;
+	ca->last_time =3D tcp_jiffies32;
+
+	if (ca->epoch_start =3D=3D 0) {
+		ca->epoch_start =3D tcp_jiffies32; /* record beginning */
+		ca->ack_cnt =3D acked; /* start counting */
+		ca->tcp_cwnd =3D cwnd; /* syn with cubic */
+
+		if (ca->last_max_cwnd <=3D cwnd) {
+			ca->bic_K =3D 0;
+			ca->bic_origin_point =3D cwnd;
+		} else {
+			/* Compute new K based on
+			 * (wmax-cwnd) * (srtt>>3 / HZ) / c * 2^(3*bictcp_HZ)
+			 */
+			ca->bic_K =3D cubic_root(cube_factor *
+					       (ca->last_max_cwnd - cwnd));
+			ca->bic_origin_point =3D ca->last_max_cwnd;
+		}
+	}
+
+	/* cubic function - calc */
+	/* calculate c * time^3 / rtt,
+	 *  while considering overflow in calculation of time^3
+	 * (so time^3 is done by using 64 bit)
+	 * and without the support of division of 64bit numbers
+	 * (so all divisions are done by using 32 bit)
+	 *  also NOTE the unit of those variables
+	 *	  time  =3D (t - K) / 2^bictcp_HZ
+	 *	  c =3D bic_scale >> 10
+	 * rtt  =3D (srtt >> 3) / HZ
+	 * !!! The following code does not have overflow problems,
+	 * if the cwnd < 1 million packets !!!
+	 */
+
+	t =3D (s32)(tcp_jiffies32 - ca->epoch_start);
+	t +=3D usecs_to_jiffies(ca->delay_min);
+
+	/* change the unit from HZ to bictcp_HZ */
+	t <<=3D BICTCP_HZ;
+	do_div(t, HZ);
+
+	if (t < ca->bic_K) /* t - K */
+		offs =3D ca->bic_K - t;
+	else
+		offs =3D t - ca->bic_K;
+
+	/* c/rtt * (t-K)^3 */
+	delta =3D (cube_rtt_scale * offs * offs * offs) >> (10 + 3 * BICTCP_HZ);
+	if (t < ca->bic_K) /* below origin*/
+		bic_target =3D ca->bic_origin_point - delta;
+	else /* above origin*/
+		bic_target =3D ca->bic_origin_point + delta;
+
+	/* cubic function - calc bictcp_cnt*/
+	if (bic_target > cwnd)
+		ca->cnt =3D cwnd / (bic_target - cwnd);
+	else
+		ca->cnt =3D 100 * cwnd; /* very small increment*/
+
+	/* The initial growth of cubic function may be too conservative
+	 * when the available bandwidth is still unknown.
+	 */
+	if (ca->last_max_cwnd =3D=3D 0 && ca->cnt > 20)
+		ca->cnt =3D 20; /* increase cwnd 5% per RTT */
+
+tcp_friendliness:
+	/* TCP Friendly */
+	if (tcp_friendliness) {
+		u32 scale =3D beta_scale;
+
+		delta =3D (cwnd * scale) >> 3;
+		while (ca->ack_cnt > delta) { /* update tcp cwnd */
+			ca->ack_cnt -=3D delta;
+			ca->tcp_cwnd++;
+		}
+
+		if (ca->tcp_cwnd > cwnd) { /* if bic is slower than tcp */
+			delta =3D ca->tcp_cwnd - cwnd;
+			max_cnt =3D cwnd / delta;
+			if (ca->cnt > max_cnt)
+				ca->cnt =3D max_cnt;
+		}
+	}
+
+	/* The maximum rate of cwnd increase CUBIC allows is 1 packet per
+	 * 2 packets ACKed, meaning cwnd grows at 1.5x per RTT.
+	 */
+	ca->cnt =3D max(ca->cnt, 2U);
+}
+
+static void roccettcp_cong_avoid(struct sock *sk, u32 ack, u32 acked)
+{
+	struct tcp_sock *tp =3D tcp_sk(sk);
+	struct roccettcp *ca =3D inet_csk_ca(sk);
+
+	u32 now =3D jiffies_to_usecs(tcp_jiffies32);
+	bool evaluate_srrtt =3D false;
+	bool send_more_than_acked =3D false;
+	u32 roccet_xj;
+	u32 jitter;
+	u32 send, received;
+
+	if (ca->state =3D=3D LAUNCH) {
+		/* LAUNCH: Detect an exit point for tcp slow start
+		 * in networks with large buffers of multiple BDP
+		 * Like in cellular networks (5G, ...).
+		 *
+		 * Or exit LAUNCH if cwnd is too large for application layer
+		 * data rate (tcp cwnd validation).
+		 * This condition is checked only after the initial round of
+		 * LAUNCH has completed. This is done in order to avoid false
+		 * positives, which can occur when the tracked outstanding
+		 * packets have not yet caught up to the initial cwnd.
+		 */
+		if ((ca->curr_srrtt > sr_rtt_upper_bound &&
+		     get_ack_rate_diff(ca) <=3D ack_rate_diff_ss) ||
+		     (!tcp_is_cwnd_limited(sk) &&
+		      ca->initial_round_completed)) {
+			ca->epoch_start =3D 0;
+
+			/* Handle initial slow start.
+			 * Most bufferbloat occurs here
+			 */
+			if (tp->snd_ssthresh =3D=3D TCP_INFINITE_SSTHRESH) {
+				tcp_sk(sk)->snd_ssthresh =3D tcp_snd_cwnd(tp)
+								/ 2;
+				/* since this is the initial slow start,
+				 * the min cwnd won't be 1, so the window
+				 * can't be set to 0 by accident.
+				 * Halfing the cwnd will undo the previous step
+				 * of slow start. Which is fine since the pipe
+				 * is already full.
+				 */
+				tcp_snd_cwnd_set(tp, max(tcp_snd_cwnd(tp) / 2,
+							 TCP_INIT_CWND));
+			} else {
+				tcp_sk(sk)->snd_ssthresh =3D
+					tcp_snd_cwnd(tp) -
+					(tcp_snd_cwnd(tp) / 3);
+				tcp_snd_cwnd_set(tp, tcp_snd_cwnd(tp) -
+						 (tcp_snd_cwnd(tp) / 3));
+			}
+			ca->roccet_last_event_time_us =3D now;
+			return;
+		}
+
+		acked =3D tcp_slow_start(tp, acked);
+		if (!acked)
+			return;
+
+	} else if (ca->state =3D=3D ORBITER) {
+		/* ORBITER: Increase the cwnd by using the CUBIC
+		 * cwnd growth function, if no roccet congestion
+		 * event is detected.
+		 */
+
+		/* Calculate jitter */
+		if ((s32)(ca->curr_rtt - ca->last_rtt) < 0)
+			jitter =3D ca->last_rtt - ca->curr_rtt;
+		else
+			jitter =3D ca->curr_rtt - ca->last_rtt;
+
+		if (ca->next_srrtt_check =3D=3D 0)
+			ca->next_srrtt_check =3D now + 5 * ca->curr_rtt;
+
+		/* Calculate if more bytes was send than received
+		 * in the time interval.
+		 *
+		 * Handle wrap arounds by relying on unsigned subtraction.
+		 * e.g. if snd_nxt wraps to 10 and seq_start is U32_MAX - 10,
+		 * the subtraction will result in the value of 21.
+		 */
+		send =3D tp->snd_nxt - ca->interval_snd_seq_start;
+		received =3D tp->snd_una - ca->interval_una_seq_start;
+
+		/* Here we use a guard space of 1% of the current cwnd.
+		 * We do this to avoid a false positive evaluation due
+		 * to delays caused by jitter or scheduling.
+		 */
+		send_more_than_acked =3D
+			send >
+			received + ((tcp_snd_cwnd(tp) * tp->mss_cache) / 100);
+
+		/* Check if it's time to evaluate the srRTT */
+		if ((s32)(ca->next_srrtt_check - now) < 0) {
+			evaluate_srrtt =3D true;
+
+			/* reset struct and set next end of period */
+			ca->next_srrtt_check =3D now + 5 * ca->curr_rtt;
+
+			/* Reset Rate calculation */
+			ca->interval_snd_seq_start =3D tp->snd_nxt;
+			ca->interval_una_seq_start =3D tp->snd_una;
+		}
+
+		/* Respects the jitter of the connection and add it on top of
+		 * the upper bound for the srRTT.
+		 */
+		roccet_xj =3D div_u64((u64)jitter * 100, ca->curr_min_rtt) +
+			    sr_rtt_upper_bound;
+		if (roccet_xj < sr_rtt_upper_bound)
+			roccet_xj =3D sr_rtt_upper_bound;
+
+		/* The srRTT exceeds the upper bound if bufferbloat happens.
+		 * Here, we want to reduce the cwnd and drain the buffer.
+		 */
+		if (ca->curr_srrtt > roccet_xj && evaluate_srrtt &&
+		    send_more_than_acked) {
+			roccet_congestion_event(sk, now);
+			return;
+		}
+
+		/* Terminates this function if cwnd is not fully utilized.
+		 * In mobile networks like 5G, this termination causes the
+		 * cwnd to be frozen at an excessively high value. This is
+		 * because slow start or HyStart massively exceed the available
+		 * bandwidth and leave the cwnd at an excessively high value.
+		 * The cwnd cannot therefore be fully utilized because it is
+		 * limited by the connection capacity.
+		 */
+		if (!tcp_is_cwnd_limited(sk) || send_more_than_acked)
+			return;
+
+		bictcp_update(ca, tcp_snd_cwnd(tp), acked);
+		tcp_cong_avoid_ai(tp, max(1, ca->cnt), acked);
+	}
+}
+
+static u32 roccettcp_ssthresh(struct sock *sk)
+{
+	return tcp_sk(sk)->snd_ssthresh;
+}
+
+static u32 roccettcp_recalc_ssthresh(struct sock *sk)
+{
+	const struct tcp_sock *tp =3D tcp_sk(sk);
+	struct roccettcp *ca =3D inet_csk_ca(sk);
+	u32 cwnd =3D tcp_snd_cwnd(tp);
+
+	/* If a loss/ECN occurs in the refill phase of min RTT probing
+	 * we reduce the cwnd and abort the refill.
+	 */
+	if (ca->state =3D=3D RTT_PROBE_REFILL)
+		ca->state =3D ORBITER;
+
+	/* If ROCCET is in min RTT probing and a loss/ECN occurs,
+	 * we use the cwnd before the probing interval to
+	 * calculate the cwnd reduction and continue probing.
+	 * After min RTT probing the cwnd is set to the reduced
+	 * value. During min RTT probing it is very likely that
+	 * congestion was caused by the cwnd value before min
+	 * RTT probing.
+	 */
+	if (ca->state =3D=3D RTT_PROBE) {
+		/* Handle ECN as cubic congestion event in min
+		 * RTT probe.
+		 */
+		ca->ece_received =3D false;
+
+		ca->epoch_start =3D 0; /* end of epoch */
+
+		/* Wmax and fast convergence */
+		if (cwnd < ca->last_max_cwnd && fast_convergence)
+			ca->last_max_cwnd =3D
+				(cwnd * (BICTCP_BETA_SCALE + beta)) /
+				(2 * BICTCP_BETA_SCALE);
+		else
+			ca->last_max_cwnd =3D cwnd;
+
+		cwnd =3D ca->cwnd_before_min_rtt_probe;
+		ca->cwnd_before_min_rtt_probe =3D
+			max((cwnd * beta) / BICTCP_BETA_SCALE, 2U);
+
+		return tcp_snd_cwnd(tp);
+	}
+
+	/* Handle ECN as ROCCET congestion event. */
+	if (ca->ece_received) {
+		ca->ece_received =3D false;
+		roccet_congestion_event(sk, jiffies_to_usecs(tcp_jiffies32));
+		return tcp_snd_cwnd(tp);
+	}
+
+	/* On loss in slow start enter congestion avoidance
+	 * without a cwnd reduction. Additional slow start
+	 * exit conditions with a cwnd reduction are handled
+	 * in roccettcp_cong_avoid.
+	 */
+	if (tcp_in_slow_start(tp))
+		return tcp_snd_cwnd(tp);
+
+	/* CUBIC congestion event */
+	ca->epoch_start =3D 0; /* end of epoch */
+
+	/* Wmax and fast convergence */
+	if (tcp_snd_cwnd(tp) < ca->last_max_cwnd && fast_convergence)
+		ca->last_max_cwnd =3D
+			(tcp_snd_cwnd(tp) * (BICTCP_BETA_SCALE + beta)) /
+			(2 * BICTCP_BETA_SCALE);
+	else
+		ca->last_max_cwnd =3D tcp_snd_cwnd(tp);
+
+	return max((tcp_snd_cwnd(tp) * beta) / BICTCP_BETA_SCALE, 2U);
+}
+
+static void roccettcp_state(struct sock *sk, u8 new_state)
+{
+	struct roccettcp *ca =3D inet_csk_ca(sk);
+	struct tcp_sock *tp =3D tcp_sk(sk);
+
+	ca->is_in_recovery =3D false;
+
+	if (new_state =3D=3D TCP_CA_Loss) {
+		roccettcp_reset(ca);
+	} else if (new_state =3D=3D TCP_CA_Recovery) {
+		ca->is_in_recovery =3D true;
+
+		/* Here we set the cwnd and ssthresh to the same value so
+		 * the TCP state machine knows we are in cong. avoid and
+		 * not in slow start.
+		 */
+		tcp_sk(sk)->snd_ssthresh =3D roccettcp_recalc_ssthresh(sk);
+		tcp_snd_cwnd_set(tp, tcp_sk(sk)->snd_ssthresh);
+	}
+}
+
+static void roccettcp_acked(struct sock *sk, const struct ack_sample *sam=
ple)
+{
+	struct roccettcp *ca =3D inet_csk_ca(sk);
+
+	/* Some calls are for duplicates without timestamps */
+	if (sample->rtt_us < 0)
+		return;
+
+	/* Discard delay samples right after fast recovery */
+	if (ca->epoch_start && (s32)(tcp_jiffies32 - ca->epoch_start) < HZ)
+		return;
+
+	u32 delay =3D sample->rtt_us;
+
+	if (delay =3D=3D 0)
+		delay =3D 1;
+
+	/* first time call or link delay decreases */
+	if (ca->delay_min =3D=3D 0 || (s32)(delay - ca->delay_min) < 0)
+		ca->delay_min =3D delay;
+
+	/* Get valid sample for roccet */
+	if (sample->rtt_us > 0) {
+		ca->last_rtt =3D ca->curr_rtt;
+		ca->curr_rtt =3D sample->rtt_us;
+	}
+}
+
+static void roccet_in_ack_event(struct sock *sk, u32 flags)
+{
+	struct roccettcp *ca =3D inet_csk_ca(sk);
+
+	/* Handle ECE bit.
+	 * Processing of ECE events is done in roccettcp_recalc_ssthresh()
+	 */
+	if (flags & CA_ACK_ECE)
+		ca->ece_received =3D true;
+}
+
+static void roccet_control(struct sock *sk, u32 ack, int flag,
+			   const struct rate_sample *rs)
+{
+	struct tcp_sock *tp =3D tcp_sk(sk);
+	struct roccettcp *ca =3D inet_csk_ca(sk);
+
+	u32 now =3D jiffies_to_usecs(tcp_jiffies32);
+	u64 rate;
+
+	/* Update roccet parameters */
+	update_ack_rate(sk, rs->acked_sacked, now);
+	update_min_rtt(sk);
+	update_srrtt(sk);
+
+	/* Update roccet state */
+	if (tcp_in_slow_start(tp)) {
+		ca->state =3D LAUNCH;
+	} else if ((s32)now - ca->roccet_last_event_time_us <=3D
+		   100 * USEC_PER_MSEC) {
+		ca->state =3D DRAIN;
+	} else if (after(now, ca->next_min_rtt_probe) ||
+		   ca->state =3D=3D RTT_PROBE || ca->state =3D=3D RTT_PROBE_REFILL) {
+		if (ca->state !=3D RTT_PROBE_REFILL)
+			ca->state =3D RTT_PROBE;
+		roccet_min_rtt_probe(sk, now);
+	} else {
+		ca->state =3D ORBITER;
+	}
+
+	/* If nothing was fully acked do not increase the cwnd */
+	if (!rs->acked_sacked)
+		return;
+
+	/* Increase the cwnd.
+	 * Loss recovery is handled in roccettcp_state()
+	 */
+	if (!ca->is_in_recovery)
+		roccettcp_cong_avoid(sk, ack, rs->acked_sacked);
+
+	/* Adjust pacing rate. The code here is similar to the
+	 * pacing rate adjustments in tcp_input.c tcp_cong_control().
+	 * In LAUNCH (slow start) we want a pacing of 200% and
+	 * in ORBITER (congestion avoidance) we adjust the pacing
+	 * to 100% and do not use the sysctl_tcp_pacing_ca_ratio.
+	 */
+
+	/* set sk_pacing_rate to 200 % of current rate (mss * cwnd / srtt) */
+	rate =3D (u64)tp->mss_cache * ((USEC_PER_SEC / 100) << 3);
+
+	/* current rate is (cwnd * mss) / srtt
+	 * In Slow Start [1], set sk_pacing_rate to 200 % the current rate.
+	 * In Congestion Avoidance phase, set it to 120 % the current rate.
+	 *
+	 * [1]: Normal Slow Start cond is (tp->snd_cwnd < tp->snd_ssthresh)
+	 *	 If snd_cwnd >=3D (tp->snd_ssthresh / 2), we are approaching
+	 *	 end of slow start and should slow down.
+	 */
+	if (tcp_snd_cwnd(tp) < tp->snd_ssthresh / 2)
+		rate *=3D READ_ONCE
+			(sock_net(sk)->ipv4.sysctl_tcp_pacing_ss_ratio);
+	else
+		/* Pacing rate of 100%
+		 * (instead of ipv4.sysctl_tcp_pacing_ca_ratio)
+		 */
+		rate *=3D 100;
+
+	rate *=3D max(tcp_snd_cwnd(tp), tp->packets_out);
+
+	if (likely(tp->srtt_us))
+		do_div(rate, tp->srtt_us);
+
+	/* WRITE_ONCE() is needed because sch_fq fetches sk_pacing_rate
+	 * without any lock. We want to make sure compiler won't store
+	 * intermediate values in this location.
+	 */
+	WRITE_ONCE(sk->sk_pacing_rate,
+		   min_t(u64, rate, READ_ONCE(sk->sk_max_pacing_rate)));
+
+	ca->initial_round_completed =3D true;
+}
+
+static struct tcp_congestion_ops roccet_tcp __read_mostly =3D {
+	.init =3D roccettcp_init,
+	.ssthresh =3D roccettcp_ssthresh,
+	.set_state =3D roccettcp_state,
+	.undo_cwnd =3D tcp_reno_undo_cwnd,
+	.cwnd_event_tx_start =3D roccettcp_cwnd_event_tx_start,
+	.pkts_acked =3D roccettcp_acked,
+	.in_ack_event =3D roccet_in_ack_event,
+	.cong_control =3D roccet_control,
+	.owner =3D THIS_MODULE,
+	.name =3D "roccet",
+};
+
+static int __init roccettcp_register(void)
+{
+	BUILD_BUG_ON(sizeof(struct roccettcp) > ICSK_CA_PRIV_SIZE);
+
+	int param_err =3D param_check(false);
+
+	if (param_err)
+		return param_err;
+
+	param_precompute();
+
+	return tcp_register_congestion_control(&roccet_tcp);
+}
+
+static void __exit roccettcp_unregister(void)
+{
+	tcp_unregister_congestion_control(&roccet_tcp);
+}
+
+module_init(roccettcp_register);
+module_exit(roccettcp_unregister);
+
+MODULE_AUTHOR("Lukas Prause, Tim F=C3=BCchsel");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("ROCCET TCP");

base-commit: 1bb784eb6e38fd73143f021608e4ef3095d0c0d7
=2D-=20
2.43.0

